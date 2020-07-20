set encoding=utf-8

if $TERM != "linux" || g:started_by_firenvim
	" Load 'colors/colors.vim'
	let g:colors_name='colors'
endif

" Choose what should be saved in the Shada file
" We use a very small number ('10) to make neovim startup faster and try to be
" smart about what files we keep.
set shada='10,:10,/10,f0,r/home/me/zsh:,r/tmp,r/run/user/1000/firenvim

set tabpagemax=9                    " Have a maximum of 9 tabs open at all time
set showtabline=1                   " Show tabline when there are at least two
set tabline=%!MyTabLine()           " MyTabLine is defined in functions.vim

set wildignorecase                  " Ignore case when completing filenames
set wildmenu                        " Adds the menu at the bottom of the screen
set wildoptions+=pum                " Cool popup menu
set wildchar=<C-n>
set wildignore+=*.o,*.out,*.class   " Ignore certain filetypes
set wildignore+=*.cmi,*.cmo
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.ico,*.svg,*.xcf
set wildignore+=*.mp3,*.ogg,*.opus,*.wav,*.flac,
set wildignore+=*.avi,*.mp4,*.mpg,*.mov,*.flv,*.webm
set wildignore+=*.pdf,*.doc,*.docx,*.xls,*.xlsx,*.odt,*.ods
set wildignore+=*.min.js
set wildignore+=*.pem
set wildignore+=*.tar,*.zip,*.rar,*.7z,*.tgz
set wildignore+=*.swp,*.swp.*,*.bak
set wildignore+=*.toc,*.nav,*.aux,*.log,*.dvi,*.cls,*.sty,*.bib

set completeopt=menu,menuone,noinsert,noselect

set showcmd                     " Show commands at the bottom of the screen
set noruler                     " Don't show cursor position at the bottom
set noshowmode                  " Don't show the mode in the line at the bottom
set laststatus=1                " Always show the statusline
set statusline=%!MyStatusLine() " Defined in functions.vim
set splitbelow                  " Open horizontal splits below
set splitright                  " Open vertical splits on the right

set list
set listchars=tab:►\ 

set lazyredraw                  " Redraw the screen only when it's needed
set autoread                    " Periodically check if the file changed

set hlsearch           " Shows the last search pattern
set incsearch          " Highlight searches as the regex is typed
set inccommand=nosplit " Display changes as they are made
set ignorecase         " Ignore case when searching
set smartcase          " Don't ignore case when uppercase in search pattern
set gdefault           " Patterns match all matches on same line by default

set hidden     " Do not unload buffers when leaving them

set backspace=indent,eol,start " backspace deletes indent, eol and stat
set matchpairs+=<:>

set nocul " shows CursorLine
set nonu  " shows line number

set foldmethod=indent " Block folding is done with syntax
set foldnestmax=10    " Fold a maximum of 10 blocks
set nofoldenable      " Don't fold on file opening

set undofile         " Enable persistent undo
set undolevels=1000  " Maximum number of changes that can be undone
set undoreload=10000 " Maximum number lines to save for undo on a buffer reload

set so=1 " Number of lines between the cursor and the top/bottom of the screen

set noerrorbells    " No error bells
set novisualbell

set modeline        " Execute vim commands that are at the end of a file
set modelines=5     " Maximum number of lines that are checked for modeline

set sidescroll=1 " When scrolling horizontally, move col by col

set nojoinspaces " Don't put 2 spaces when joining lines

set expandtab

set cino+=#1 " Make >> be able to shift lines that start with '#' in C

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/ " Highlight eol whitespace in red

let g:loaded_netrw = 1                 " Netrw is rather annoying, diable it
let g:loaded_netrwPlugin = 1
let g:netrw_dirhistmax=0               " Do not write to ~/.vim/netrwist
let g:netrw_banner=0                   " Hide the filebrowser banner
let g:netrw_browsex_viewer= "xdg-open" " Open files with xdg-open

let g:tex_flavor = "latex"             " Sets which kind of latex I use

