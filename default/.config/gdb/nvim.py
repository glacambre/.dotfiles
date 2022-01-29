#!/usr/bin/env python3
import os

class Nvim():
    def __enter__(self):
        from pynvim import attach
        addr = os.environ.get("NVIM_LISTEN_ADDRESS", None)
        self.nvim = attach("socket", path=addr)
        return self.nvim
    def __exit__(self, type, value, traceback):
        self.nvim.stop_loop()

def find_buf_for(n, name):
    bufs = [buf for buf in n.api.list_bufs() if n.api.buf_get_name(buf) == name]
    if len(bufs) < 1:
        return None
    return bufs[0]

def get_buf_named(n, name):
    buf = find_buf_for(n, name)
    if buf is None:
        buf = n.api.call_function("bufadd", name)
    return buf

def find_window_for(n, file):
    buf = find_buf_for(n, file)
    if buf is None:
        return None
    wins = [win for win in n.api.list_wins() if n.api.win_get_buf(win) == buf]
    if len(wins) < 1:
        return None
    return wins[0]

def get_window_for(n, file):
    win = find_window_for(n, file)
    if win is None:
        n.command(f"split {file}")
        win = [win for win in n.api.list_wins() if n.api.win_get_buf(win) == buf][0]
    return win

sign_group = "gdb/current"
frame_sign = "gdb/frame_sign"
focused_frame_sign = "gdb/focused_frame_sign"

def gather_frames(gdb):
    frame = gdb.newest_frame()
    result = []
    while frame:
        result.append(frame)
        frame = frame.older()
    return reversed(result)

def gather_usable_frames(gdb):
    result = []
    for frame in gather_frames(gdb):
        symtab = frame.find_sal().symtab
        if symtab is not None and os.path.exists(symtab.fullname()):
            result.append(frame)
    return result

def gather_old_signs(n):
    result = {}
    for buf in n.api.list_bufs():
        name = n.api.buf_get_name(buf)
        result[buf] = n.api.call_function("sign_getplaced", [name, {'group': sign_group}])
    return result

def place_signs(n, frames):
    for frame in frames:
        sal = frame.find_sal()
        name = sal.symtab.fullname()
        if not os.path.exists(name):
            continue
        buf = find_buf_for(n, name)
        if buf is None:
            continue
        line = sal.line
        n.api.call_function("sign_place", [0, sign_group, frame_sign, name, {'lnum': line}])
        win = find_window_for(n, name)
        if win is None:
            continue
        n.api.win_set_cursor(win, [line, 0])

last_used_window = None
def place_focused_sign(n, gdb):
    global last_used_window
    selected_frame = gdb.selected_frame()
    sal = selected_frame.find_sal()
    if sal is None:
        return
    filename = sal.symtab.fullname()
    if not os.path.exists(filename):
        return
    line = sal.line
    win = find_window_for(n, filename)
    if win is None:
        if last_used_window is None or not n.api.win_is_valid(last_used_window):
            focus = n.api.get_current_win()
            n.command(f"split {filename}")
            n.api.call_function("win_gotoid", [focus])
            win = get_window_for(n, filename)
        else:
            buf = get_buf_for(n, filename)
            n.win_set_buf(buf)
            win = last_used_window
    last_used_window = win
    n.api.call_function("sign_define", [focused_frame_sign, {'text': '»', 'texthl': 'String'}])
    n.api.win_set_cursor(win, [line, 0])
    n.api.call_function("sign_place", [0, sign_group, focused_frame_sign, filename, {'lnum': line}])

def on_stopped(event):
    with Nvim() as n:
        n.api.call_function("sign_define", [frame_sign, {'text': '»'}])
        oldsigns = gather_old_signs(n)
        place_signs(n, gather_usable_frames(gdb))
        for buf in oldsigns:
            for sign in oldsigns[buf][0]['signs']:
                n.api.call_function("sign_unplace", [sign_group, sign])
        place_focused_sign(n, gdb)

# class NvimCommand (gdb.Command):
#     def __init__ (self):
#         super (NvimCommand, self).__init__ ("nvim", gdb.COMMAND_USER)

#     def invoke(self, arg, from_tty):
#         with Nvim() as n:
#             global neovim_window
#             if neovim_window is not None:
#                 if n.api.win_is_valid(neovim_window):
#                     return
#                 else:
#                     neovim_window = None
#             print(gdb.selected_inferior().progspace.filename)
#             try:
#                 selected_frame = gdb.selected_frame()
#                 sal = selected_frame.find_sal()
#                 filename = sal.symtab.fullname()
#                 line = sal.line
#                 n.command(f"split +{line} {filename}")
#                 neovim_window = n.api.get_current_win()
#             except Exception as e:
#                 print(e)
# NvimCommand()

gdb.events.stop.connect(on_stopped)
