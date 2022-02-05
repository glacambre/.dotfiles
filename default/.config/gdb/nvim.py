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

frame_group = "gdb/frames"
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
        sal = frame.find_sal()
        if sal is None:
            continue
        if sal.symtab is not None and os.path.exists(sal.symtab.fullname()):
            result.append(frame)
    return result

def gather_old_signs(n):
    result = {}
    for buf in n.api.list_bufs():
        name = n.api.buf_get_name(buf)
        result[buf] = n.api.call_function("sign_getplaced", [name, {'group': frame_group}])
    return result

def place_signs(n, frames):
    for frame in frames:
        sal = frame.find_sal()
        name = sal.symtab.fullname()
        if not os.path.exists(name):
            continue
        if get_buf_named(n, name) is None:
            continue
        line = sal.line
        n.api.call_function("sign_place", [0, frame_group, frame_sign, name, {'lnum': line}])
        win = find_window_for(n, name)
        if win is None:
            continue
        n.api.win_set_cursor(win, [line, 0])

def place_focused_sign(n, gdb):
    selected_frame = gdb.selected_frame()
    sal = selected_frame.find_sal()
    if sal is None or sal.symtab is None:
        return
    filename = sal.symtab.fullname()
    if not os.path.exists(filename):
        return
    line = sal.line
    win = find_window_for(n, filename)
    if win is not None:
        n.api.win_set_cursor(win, [line, 0])
    else:
        if get_buf_named(n, filename) is None:
            return
    n.api.call_function("sign_define", [focused_frame_sign, {'text': '»', 'texthl': 'String'}])
    n.api.call_function("sign_place", [0, frame_group, focused_frame_sign, filename, {'lnum': line}])

def on_stopped(event):
    with Nvim() as n:
        n.api.call_function("sign_define", [frame_sign, {'text': '»'}])
        oldsigns = gather_old_signs(n)
        place_signs(n, gather_usable_frames(gdb))
        for buf in oldsigns:
            for sign in oldsigns[buf][0]['signs']:
                n.api.call_function("sign_unplace", [frame_group, sign])
        place_focused_sign(n, gdb)

breakpoint_group = "gdb/breakpoints"
breakpoint_sign = "gdb/breakpoint_sign"

def place_breakpoints(id, sals):
    with Nvim() as n:
        n.api.call_function("sign_define", [breakpoint_sign, {'text': '●'}])
        for sal in sals:
            if sal.symtab is None:
                continue
            name = sal.symtab.fullname()
            if not os.path.exists(name):
                continue
            if get_buf_named(n, name) is None:
                continue
            n.api.call_function("sign_place", [id, breakpoint_group, breakpoint_sign, name, {'lnum': sal.line}])

def on_breakpoint_created(breakpoint):
    if breakpoint.location is None:
        return
    try:
        (_, locs) = gdb.decode_line(breakpoint.location)
    except:
        return
    place_breakpoints(breakpoint.number, locs)

def on_breakpoint_deleted(breakpoint):
    if breakpoint.location is None:
        return
    with Nvim() as n:
        n.api.call_function("sign_unplace", [breakpoint_group, {'id': breakpoint.number}])

def on_breakpoint_modified(breakpoint):
    if breakpoint.enabled:
        on_breakpoint_created(breakpoint)
    else:
        on_breakpoint_deleted(breakpoint)

gdb.events.stop.connect(on_stopped)
gdb.events.breakpoint_created.connect(on_breakpoint_created)
gdb.events.breakpoint_deleted.connect(on_breakpoint_deleted)
