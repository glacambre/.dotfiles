" Generates the tabline
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'
        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    return s
endfunction

" Generates the labels for the tab line
function! MyTabLabel(n)
    " Insert Tab Number
    let s = '[' . a:n . ']'
    let maxtabwidth = 20
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    " If modified, add '[+]'
    if getbufvar(buflist[winnr - 1], '&modified') == 1
        let s = s . '[+]'
    endif
    " If in terminal, display only term://name
    if getbufvar(buflist[winnr - 1], '&buftype') == 'terminal'
        let n = substitute(matchstr(bufname(buflist[winnr - 1]), ":[^:]*$"), ":", "", "")
    else
        let n = bufname(buflist[winnr - 1])
        if n == ""
            let n = "No Name"
        else
            let n = fnamemodify(n, ":p")
        endif
    endif
    let namewidth = strwidth(n)
    let curwidth = strwidth(s)
    if namewidth + curwidth > maxtabwidth
        let n = "..." . strpart(n, namewidth - maxtabwidth + curwidth + 3)
    endif
    return s . "[" . n . "]"
endfunction

" Generates the wanted format for the statusline
function! MyStatusLine ()
    let l:line = ''
    if &ft == 'qf'
        return '%q'
    endif

    let l:mode = mode()
    if l:mode == 'n'
        let l:line .= '[NORMAL]'
    elseif l:mode == 'i' || l:mode == 't'
        let l:line .= '[INSERT]'
    elseif l:mode == 'v'
        let l:line .= '[VISUAL]'
    endif
    let l:line .= '%y[%f]%m%r%='
    let l:line .= '%{MyNeomakeStatusItem()}'
    return l:line . '[%l,%c:%b][%P]'
endfunction

function! MyNeomakeStatusItem()
    if !exists('*neomake#statusline#LoclistCounts()')
        return ""
    endif
    let counts = neomake#statusline#LoclistCounts(bufnr("%"))
    let ecount = get(counts, "E", 0)
    let wcount = get(counts, "W", 0)
    if ecount > 0 && wcount > 0
        return "[E:" . ecount . ",W:" . wcount . "]"
    elseif ecount > 1
        return "[" . ecount . " errors]"
    elseif ecount > 0
        return "[" . ecount . " error]"
    elseif wcount > 1
        return "[" . wcount . " warnings]"
    elseif wcount > 0
        return "[" . wcount . " warning]"
    endif
    return ""
endfunction

" Updates/lauches mupdf
function! UpdateLatexPdfDisplay()
    " If a mupdf instance has been found, update it with a hup signal.
    " Otherwise, start a mupdf instance.
    if &ft != "tex"
        return
    endif
    silent exec '!
                \ found=false;
                \ for i in `pidof mupdf-x11`; do;
                \ if [ `xargs -0 < /proc/$i/cmdline | grep -c "' . expand('%:p:r') . '.pdf"` -ge 1 ] ; then;
                \ kill -1 $i;
                \ found=true;
                \ break;
                \ fi;
                \ done;
                \ if [ $found = false ]; then;
                \ mupdf "' . expand('%:p:r') . '.pdf" &;
                \ fi'
endfunction

" Called when a new term is created
function! OnTermOpen()
    " Use a pretty name for the buffer
    execute("file " . substitute(expand("%"), "term://.//", "", ""))

    " Splitting opens a new term
    nnoremap <buffer> <silent> <C-w>s :split<CR>:term<CR>
    nnoremap <buffer> <silent> <C-w>v :vsplit<CR>:term<CR>

    " When leaving a term buffer, remember whether it was in insert or normal
    " mode. When entering a terminal window/buffer, go in insert mode if the
    " term was in insert mode.
    let b:should_insert = 1
    au BufEnter <buffer> if b:should_insert == 1 | startinsert | endif
    au BufLeave <buffer> stopinsert
    nnoremap <buffer> <silent> a :set laststatus=1<CR>:let b:should_insert = 1<CR>a
    nnoremap <buffer> <silent> i :set laststatus=1<CR>:let b:should_insert = 1<CR>i

    " Get max scrollback
    setlocal scrollback=-1

    " Disable scrolloffset because it doesn't work nicely when the cursor is
    " in a row < to scrolloffset while in terminal mode
    setlocal scrolloff=0

    " When opening a new term, go in insert mode
    startinsert
    let b:should_insert = 1
endfunction

"When closing a terminal, feed enter to close the buffer or leave nvim if it
"was the only buffer
function! OnTermClose()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        :quit!
    else
        call feedkeys(" ")
    endif
endfunction

" Converts encoding to utf8
function! FixEncoding()
    :update
    :setlocal fileencoding=utf8
    :e ++ff=dos
    :setlocal ff=unix
endfunction

" Called on <C-z>. If nvim is running directly in a terminal (e.g. not in a
" shell), prevent it from being suspended. 
function! SuspendIfInShell()
    let parent_name=substitute(system("ps -o comm= $(ps -p '" . getpid() . "' -o ppid=)"), '\n$', '\1', '')
    if (match(['Eterm', 'alacritty', 'aterm', 'gnome-terminal', 'kitty',
                \ 'konsole', 'login', 'lxterminal', 'mate-terminal',
                \ 'mlterm', 'nvim-gtk', 'qterminal', 'roxterm', 'rxvt',
                \ 'rxvtc', 'rxvtcd', 'st', 'terminator', 'terminology',
                \ 'terminte', 'termit', 'urxvt', 'urxvtc', 'urxvtcd',
                \ 'urxvtd', 'uxterm', 'x-terminal-emulator', 'xfce4-terminal',
                \ 'xterm'], parent_name) != -1)
        echo "Suspend: Not suspended because running in " . parent_name
    else
        :suspend
    endif
endfunction

" Iterates over a list of buffers, if a loaded but non-displayed buffer
" exists, switches to it and returns 1, 0 otherwise
function! SwitchToBuf(buflist)
    for idx in a:buflist
        if len(win_findbuf(idx)) == 0
            execute "buffer " . idx
            return 1
        endif
    endfor
    return 0
endfunction

" Closes a buffer while keeping its window open.
function! WipeButKeepOpen(force)
    " btarget is the id of the current buffer
    let btarget = bufnr("%")
    " allbufs is a list of all listed buffers
    let allbufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let nbbufs = len(allbufs)

    let closebuf = "bw"
    " Choose whether to force wipe the buffer or not
    if a:force == 1 || &buftype == "terminal"
        let closebuf = closebuf . "!"
    endif
    let closebuf = closebuf . " " . btarget

    let idx = index(allbufs, btarget)
    let nextbufs = allbufs[idx:]
    " If switching to the next unloaded buf fails, try to swith to a prev
    if SwitchToBuf(nextbufs) != 1
        let prevbufs = reverse(allbufs[:idx])
        " Try to switch to the previous undisplayed buffer
        call SwitchToBuf(prevbufs)
    endif

    try
        " Close the buffer
        execute closebuf
    catch
        " Closing didn't work, go back to the target
        execute "buffer " . btarget
        echoerr "Couldn't wipe buffer. Unsaved changes?"
    endtry


    " If the current buffer is now an empty buffer
    if (bufname('%') == '' && line('$') == 1 && getline(1) == '') || &ft == "netrw"
        " If the buffer we just closed was the last
        if nbbufs <= 1
            quit
        else
            call WipeButKeepOpen(0)
        endif
    endif

endfunction

function! SetNetrwMappings()
    nnoremap <buffer> x :silent call WipeButKeepOpen(0)<CR>
    nnoremap <buffer> X :silent call WipeButKeepOpen(1)<CR>
endfunction

" Function called when running $VIMRUNTIME/macros/less.sh
function! LessInitFunc()
    set nolist
    set nocursorcolumn nocursorline
    set laststatus=0
    set readonly
endfunction

function! GenerateCHeaderSkeleton()
    " If the file isn't empty, abort
    if line('$') != 1 || getline(1) != ''
        return
    endif
    " Grab the filename and use it to get a good include guard name
    let l:definename = substitute(toupper(expand('%:t')), "\\.", "_", "g")
    " Append the beginning of the include guard
    call append(0, ["#ifndef " . l:definename, "#define " . l:definename])
    " Try to find a c file that has the same name
    let l:filename = expand("%:t:r") . ".c"
    let l:file = findfile(l:filename, "..")
    if l:file != ""
        " If this file exists, find lines that look like function declarations
        let l:lines = filter(readfile(l:file), 'match(v:val, "^\\(struct\\s*\\)\\?[a-z0-9_]\\+\\s*\\*\\?\\s*[a-z0-9_]\\+\\s*(") == 0')
        " Make them look like regular signatures
        let l:lines = map(l:lines, 'substitute(v:val, ")[^)]*$", ");", "")')
        " And add them to the file
        call append(line('$'), l:lines)
    endif

    " Close the include guard
    call append(line('$'), ["#endif"])
    " Go back to the line before the end of the include guard
    call cursor(line('$') - 2, 1)
    set ft=c
endfunction

" Saves the prompt position
" pid: The pid of the shell that should be saved
" from_precmd: 1 if called from a precmd zsh hook, 0 otherwise
" ps1: The PS1, can contain escape sequences
function! SavePrompt(pid, from_precmd, ps1, cmdheight) abort
    let allbufs = getbufinfo()
    " Find the buffer that belongs to the shell that has pid a:pid
    let bufnr = 0
    for i in range(len(allbufs))
        if get(allbufs[i]["variables"], "terminal_job_pid", 0) == a:pid
            let bufnr = allbufs[i]["bufnr"]
            break
        endif
    endfor
    if bufnr == 0
        return
    endif

    " Save currently selected buffer
    let curbuf = bufnr("%")
    " Go to shell buffer
    exe "buffer " . bufnr

    let prompt_line = 1
    " Try to find the last line with text
    try
        $;?.
        let prompt_line = line('.')
    catch
        " Fails if the buffer is empty
        let prompt_line = 1
    endtry
    let prompt_line = (prompt_line - a:cmdheight)

    " Save current cursor line and ps1
    if !exists('b:shell_prompts') || !exists('b:ps1_lengths')
        let b:shell_prompts = []
        let b:ps1_lengths = {}
    endif

    let b:shell_prompts += [prompt_line]
    let b:ps1_lengths["" . b:shell_prompts[-1]] = len(substitute(a:ps1, '\[[^m]\+m', '', 'g'))

    " Go back to the buffer we were on before calling the function
    exe "buffer " . curbuf
endfunction

" Goes to the next/previous term prompt
" prev: 1 if we want the previous prompt, 0 if we want the next
function! TermPrompt(prev) abort range
    if !exists('b:shell_prompts') || !exists('b:ps1_lengths')
        return
    endif

    " Find the prompt line after the cursor
    let curline = line('.')
    let i = 0
    while i < len(b:shell_prompts) && (b:shell_prompts[i]) < curline
        let i += 1
    endwhile

    if a:prev
        let i = i - 1
    else
        " If the cursor is already on prompt, get the next one
        let i += i < len(b:shell_prompts) && b:shell_prompts[i] == curline
    endif

    let action = ""
    if (i >= 0 && i < len(b:shell_prompts)) 
        " Compute how many lines the cursor should be moved {horizonta,vertica}lly
        let target_line = b:shell_prompts[i]
        let target_col = b:ps1_lengths["" + target_line] + 1

        let lcount = (target_line - curline)
        if lcount > 0
            let action = lcount . "j"
        elseif lcount < 0
            let action = (-lcount) . "k"
        endif

        let ccount = (target_col - col('.'))
        if ccount > 0
            let action .= ccount . "l"
        elseif ccount < 0
            let action .= (-ccount) . "h"
        endif
    endif
    return action
endfunction

function! SetGCCStyle()
  let l:fname = expand("%:p")
  if stridx(l:fname, 'libsanitizer') != -1
    return
  endif
  let l:ext = fnamemodify(l:fname, ":e")
  let l:c_exts = ['c', 'h', 'cpp', 'cc', 'C', 'H', 'def', 'java']
  if index(l:c_exts, l:ext) != -1
    setlocal cindent
    setlocal tabstop=8
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal noexpandtab
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,f0,h2,p4,t0,+2,(0,u0,w1,m0
    setlocal textwidth=80
    setlocal formatoptions-=ro formatoptions+=cqlt
  endif
endfunction

function! FillNeovimIssueTemplate() abort
  let l:version = ''
  redir => l:version
  version
  redir END
  let l:version = split(l:version, "\n")[0]

  let l:os = ''
  redir => l:os
  execute('!uname -poivrs')
  redir END
  let l:os = split(l:os, "\n")[2]

  let l:term = ''
  redir => l:term
  execute('!' . $HOME . '/bin/term --version')
  redir END
  let l:term = split(l:term, "\n")[2]

  let l:content = join(nvim_buf_get_lines(0, 0, -1, v:false), "\n")
  let l:version_field = '- `nvim --version`:'
  let l:content = substitute(l:content, l:version_field, l:version_field . ' ' . l:version, 'g')
  let l:os_field = '- Operating system/version:'
  let l:content = substitute(l:content, l:os_field, l:os_field . ' ' . l:os, 'g')
  let l:term_field = '- Terminal name/version:'
  let l:content = substitute(l:content, l:term_field, l:term_field . ' ' . l:term, 'g')
  call nvim_buf_set_lines(0, 0, -1, v:false, split(l:content, "\n"))
endfunction
