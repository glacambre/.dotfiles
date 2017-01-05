if 1
    let mapleader = " " " Leader key is space
endif

" leader twice disables currently matched search pattern
nnoremap <leader><leader> :nohlsearch<CR>
" leader v opens the current buffer in a vertical split
nnoremap <leader>v <ESC>:vs<CR>
" leader h opens the current buffer in a horizontal split
nnoremap <leader>h <ESC>:sp<CR>
" leader t opens the current buffer in a new tab
nnoremap <leader>t <ESC>:tab split<CR>
" leader r sources the current file
nnoremap <leader>r <ESC>:source %<CR>

" wrapped lines: go to next row instead of next line
nnoremap j gj
nnoremap k gk

" Y yanks to the end of the line instead of the whole line (like D)
nnoremap Y y$
" vv selects the whole line, just like dd deletes the whole line
nnoremap vv V
" V selects till the end of the line just like D deletes till eol
nnoremap V v$h
" Yanking in visual mode doesn't move the cursor back to where it was
vnoremap <expr>y "my\"" . v:register . "y`y"

" s saves current buffer
nnoremap s :w<CR>
" S saves with sudo
nnoremap S :w !sudo tee > /dev/null %<CR>

" x closes the current buffer
nnoremap x :silent call WipeButKeepOpen(0)<CR>
" X closes the current buffer even if it was modified
nnoremap X :close<CR>

" R reloads the current buffer
nnoremap R :e!<CR>

" . repeats the last action on a visual block
vnoremap . :normal .<CR>

" Move between splits with alt+mov key
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
noremap <A-H> <C-w>H
noremap <A-J> <C-w>J
noremap <A-K> <C-w>K
noremap <A-L> <C-w>L
inoremap <A-h> <Esc><C-w>h
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-l> <Esc><C-w>l
inoremap <A-H> <Esc><C-w>H
inoremap <A-J> <Esc><C-w>J
inoremap <A-K> <Esc><C-w>K
inoremap <A-L> <Esc><C-w>L
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-H> <C-\><C-n><C-w>H
tnoremap <A-J> <C-\><C-n><C-w>J
tnoremap <A-K> <C-\><C-n><C-w>K
tnoremap <A-L> <C-\><C-n><C-w>L
tnoremap <A-Space> <C-\><C-n>:set laststatus=2<CR>:let b:should_insert = 0<CR>:tnoremap <A-Space> <C-\><C-n>:silent let b:should_insert=0<CR>

" Resize splits using +hjkl
nnoremap +h <C-w><<CR>
nnoremap +j <C-w>+<CR>
nnoremap +k <C-w>-<CR>
nnoremap +l <C-w>><CR>

" Move in insert mode using hjkl
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

" Suggest a spelling correction
nnoremap <C-s> z=
inoremap <C-x><C-s> <C-x><C-s><C-n>

" Move in command line mode using hjkl
cnoremap <C-H> <left>
cnoremap <C-J> <down>
cnoremap <C-K> <up>
cnoremap <C-L> <right>

" Go to a tab by using alt+colnum
noremap <A-&> 1gt
noremap <A-é> 2gt
noremap <A-"> 3gt
noremap <A-'> 4gt
noremap <A-(> 5gt
noremap <A--> 6gt
noremap <A-è> 7gt
noremap <A-_> 8gt
noremap <A-ç> 9gt
noremap <A-à> 10gt

" Move tabs by using alt+shift+colnum
noremap <A-1> :tabm 0<CR>
noremap <A-2> :tabm 1<CR>
noremap <A-3> :tabm 2<CR>
noremap <A-4> :tabm 3<CR>
noremap <A-5> :tabm 4<CR>
noremap <A-6> :tabm 5<CR>
noremap <A-7> :tabm 6<CR>
noremap <A-8> :tabm 7<CR>
noremap <A-9> :tabm 8<CR>
noremap <A-0> :tabm 9<CR>

" Create a new tab
nnoremap <silent> <C-w>t :tabnew<CR>

" Redo with U
nnoremap U <C-r>

" TODO: Play last recorded macro with Q
nnoremap Q @@

" Do not exit Visual mode when shift-indenting
vnoremap < <gv
vnoremap > >gv
" Do not exit Visual mode when incrementing
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv
" Do not exit Visual mode after changing case
vnoremap ~ ~gv

" Split and check whether a new term should be started in the new window
nnoremap <C-w>s :silent call OpenNewTermIfTermSplit(0)<CR>
nnoremap <C-w>v :silent call OpenNewTermIfTermSplit(1)<CR>

" Call a function that checks whether we can suspend or not
nnoremap <C-z> :call SuspendIfInShell()<CR>
vnoremap <C-z> <Esc> :call SuspendIfInShell()<CR>gv

" Makes selections easier on an azerty keyboard
" r => rectangles
onoremap ar a]
xnoremap ar a]
onoremap ir i]
xnoremap ir i]

" q => quotes
onoremap aq a'
xnoremap aq a'
onoremap iq i'
xnoremap iq i'

" d => doublequote
onoremap ad a"
xnoremap ad a"
onoremap id i"
xnoremap id i"

