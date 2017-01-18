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
    if exists('*gutentags#statusline()')
        let l:line .= '[%{gutentags#statusline()}]'
    endif
    return l:line . '[%l,%c:%b][%P]'
endfunction

function! MyNeomakeStatusItem()
    if !exists('*neomake#statusline#LoclistCounts()')
        return ""
    endif
    let counts = neomake#statusline#LoclistCounts()
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

" Compiles and updates/lauches mupdf when editing latex files
function! CompileAndUpdate()
    " If a toc file exists, compile twice. Then iterate over mupdf pids
    " in order to find one that has been called with the current filename.
    " If a mupdf instance has been found, update it with a hup signal.
    " Otherwise, start a mupdf instance.
    " TODO: Turn this into a custom neomake maker.
    !pdflatex % && (if [ -e %:r.toc ]; then;
                    \ pdflatex %;
                \ fi;
                \ found=false;
                \ for i in `pidof mupdf-x11`; do;
                    \ if [ `xargs -0 < /proc/$i/cmdline | grep -c "%:r.pdf"` -ge 1 ] ; then;
                        \ kill -1 $i;
                        \ found=true;
                        \ break;
                    \ fi;
                \ done;
                \ if [ $found = false ]; then;
                    \ mupdf %:r.pdf &;
                \ fi;)
endfunction

" Called when a new term is created
function! OnTermOpen()
    " Use a pretty name for the buffer
    execute("file " . substitute(expand("%"), "term://.//", "", ""))

    " Remember as many lines as possible
    set scrollback=-1

    " Splitting opens a new term
    nnoremap <buffer> <silent> <C-w>s :split<CR>:term<CR>
    nnoremap <buffer> <silent> <C-w>v :vsplit<CR>:term<CR>

    " When leaving a term buffer, remember whether it was in insert or normal
    " mode. When entering a terminal window/buffer, go in insert mode if the
    " term was in insert mode.
    let b:should_insert = 1
    au BufEnter <buffer> if b:should_insert == 1 | startinsert | endif
    au WinEnter <buffer> if b:should_insert == 1 | startinsert | endif
    nnoremap <buffer> <silent> a :let b:should_insert = 1<CR>a
    nnoremap <buffer> <silent> i :let b:should_insert = 1<CR>i
    startinsert

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

" Called on <C-z>. If nvim isn't running in a shell, prevent it from
" suspending. If it is, suspend.
function! SuspendIfInShell()
    let parent_name=substitute(system("ps -o comm= $(ps -p '" . getpid() . "' -o ppid=)"), '\n$', '\1', '')
    if (match([ 'zsh','bash','csh','ksh','ash','sh' ], parent_name) != -1)
        :suspend
    else
        echo "Suspend: Not suspended because running in " . parent_name
    endif
endfunction

" Iterates over a list of buffers, if a loaded but non-displayed buffer
" exists, switches to it and returns 1, 0 otherwise
function! SwitchToBuf(buflist)
    let switched = 0
    for idx in a:buflist
        if bufloaded(idx) == 1 && bufwinnr(idx) == -1
            execute "buffer " . idx
            let switched = 1
            break
        endif
    endfor
    return switched
endfunction

" Closes a buffer while keeping its window open.
function! WipeButKeepOpen(force)
    " btarget is the id of the current buffer
    let btarget = bufnr("%")
    " allbufs is a list of all listed buffers
    let allbufs = filter(range(1, bufnr('$')), 'bufloaded(v:val)')
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

    " If the buffer we just closed was the last
    if nbbufs <= 1
        quit
    endif

    " If the current buffer is now an empty buffer
    if bufname('%') == '' && line('$') == 1 && getline(1) == ''
        close
    endif

endfunction

function! SetNetrwMappings()
    nnoremap <buffer> x :silent call WipeButKeepOpen(0)<CR>
    nnoremap <buffer> X :silent call WipeButKeepOpen(1)<CR>
endfunction

" Function called when running $VIMRUNTIME/macros/less.sh
function! LessInitFunc()
    set nocursorcolumn nocursorline
    set laststatus=0
    set readonly
    call ShowTrailingWhitespace#Set(0,1)
endfunction
