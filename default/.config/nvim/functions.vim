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
    return l:line . '[%l,%c:%b][%P]'
endfunction

" Called when a new term is created
function! OnTermOpen()
    " When leaving a term buffer, remember whether it was in insert or normal
    " mode. When entering a terminal window/buffer, go in insert mode if the
    " term was in insert mode.
    au TermEnter <buffer> let b:should_insert = 1
    au BufEnter <buffer> if b:should_insert == 1 | startinsert | endif

    " When there is a single window and it's a terminal, don't display the
    " statusline in terminal mode. This saves a line of space.
    au TermEnter <buffer> if len(nvim_list_wins()) == 1 | set laststatus=1 | endif
    au TermLeave <buffer> set laststatus=2

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

" Function called when running $VIMRUNTIME/macros/less.sh
function! LessInitFunc()
    set nolist
    set nocursorcolumn nocursorline
    set laststatus=0
    set readonly
endfunction
