" <Space>twice disables highlighting of currently matched search pattern
nnoremap <Space><Space> :nohlsearch<CR>
" Close quickfix/location list
nnoremap <Space>qc :ccl<CR>
nnoremap <Space>lc :lcl<CR>
" Next/previous item in the quickfix list
nnoremap <Space>qn :qnext<CR>
nnoremap <Space>qp :qprev<CR>
" Next/previous item in the location list
nnoremap <Space>ln :lnext<CR>
nnoremap <Space>lp :lprev<CR>
" Earlier/later item in the undo list
nnoremap <Space>ue :earlier<CR>
nnoremap <Space>ul :later<CR>

" wrapped lines: go to next row instead of next line
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

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
nnoremap S :set nomodified<CR>:w !sudo tee > /dev/null %<CR><CR>

" x closes the current buffer
nnoremap <silent> x :call WipeButKeepOpen(0)<CR>
" X closes the current buffer even if it was modified
nnoremap <silent> X :close<CR>

" R reloads the current buffer
nnoremap R :e!<CR>

" . repeats the last action on a visual block
vnoremap . :normal .<CR>

" Move between splits with alt+mov key
for i in ['h', 'j', 'k', 'l', 'H', 'J', 'K', 'L']
    execute('noremap <A-' . i . '> <C-w>' . i)
    execute('inoremap <A-' . i . '> <Esc><C-w>' . i)
    execute('tnoremap <A-' . i . '> <C-\><C-n><C-w>' . i)
endfor
function! ChangeASpaceKeybind() abort
      set laststatus=2
      let b:should_insert = 0
      tnoremap <silent> <A-Space> <C-\><C-n>:let b:should_insert = 0<CR>
endfunction
tnoremap <silent> <A-Space> <C-\><C-n>:call ChangeASpaceKeybind()<CR>

" Suggest a spelling correction
nnoremap <C-s> z=
inoremap <C-x><C-s> <C-x><C-s><C-n>

" Move in command line mode using hjkl
for b in [["<C-h>", "<left>"],
	\ ["<C-j>", "<down>"],
	\ ["<C-k>", "<up>"],
	\ ["<C-l>", "<right>"],
	\ ["<C-a>", "<Home>"],
	\ ["<C-e>", "<End>"]]
    execute('lnoremap ' . b[0] . ' ' . b[1])
    execute('cnoremap ' . b[0] . ' ' . b[1])
    " Warning: Unexpected behavior might ensue when it comes to closing
    " completion menu because of <C-e>
    execute('inoremap <expr> ' . b[0] . ' (pumvisible() ? "\<C-e>" : "") . "\' . b[1] . '"')
endfor

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
let i = 1
while i < 10
    execute('noremap  <silent> <A-' . i . '> :tabm ' . i . '<CR>')
    execute('inoremap <silent> <A-' . i . '> <Esc>:tabm ' . i . '<CR>')
    let i = i + 1
endwhile

" Create a new tab
nnoremap <silent> <C-w>t :tabnew<CR>

" Redo with U
nnoremap U <C-r>

" TODO: Play last recorded macro with Q
nnoremap Q @@

" This is needed because of mathchpairs+=<:> in settings.vim
nnoremap << :<<CR>
" Do not exit Visual mode when shift-indenting
vnoremap < <gv
vnoremap > >gv
" Do not exit Visual mode when incrementing
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv
" Do not exit Visual mode after changing case
vnoremap ~ ~gv

" Call a function that checks whether we can suspend or not
nnoremap <C-z> :call SuspendIfInShell()<CR>
vnoremap <C-z> <Esc>:call SuspendIfInShell()<CR>gv

" Insert mode: go to beginning of word
inoremap <C-b> <C-o>b
" Insert mode: go to end of word
inoremap <C-f> <C-o>e
" Insert mode: delete following word
inoremap <expr><C-d> strcharpart(getline('.')[col('.') - 1:], 0, 1) == ' ' ? "\<C-o>d2w" : "\<C-o>dw"

" Make backspace delete characters in normal mode
nnoremap <Backspace> hx

" Open current url/file (same as Netrw, without the awful file browser)
nnoremap gx :execute('silent! !xdg-open ' . expand('<cfile>'))<CR>
