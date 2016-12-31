set encoding=utf-8
if has("autocmd")
  filetype plugin indent on           "filetype detection
endif
if has('syntax')
  syntax on                           "syntax highlighting
  colorscheme paramount
endif

set switchbuf=usetab,newtab         " Try to treat buffers as tabs
set tabpagemax=9                    " Have a maximum of 20 tabs open at all time
set showtabline=1                   " Show tabline when there are at least two
set tabline=%!MyTabLine()           " MyTabLine is defined in functions.vim

set wildmenu                        " Adds the menu at the bottom of the screen
set wildmode=list:longest,list:full " Wildmenu gives a list of all matches
set wildignore+=*.o,*.out,*.class   " Ignore certain filetypes
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.ico,*.svg
set wildignore+=*.mp3,*.ogg,*.opus,*.wav,*.flac,
set wildignore+=*.avi,*.mp4,*.mpg,*.mov,*.flv,*.webm
set wildignore+=*.pdf,*.doc,*.docx,*.xls,*.xlsx
set suffixes+=.swp,.swp.*,.bak      " Give lower priority to theses suffixes
set suffixes+=.toc,.nav,.aux,.log,.dvi

set showcmd                         " Show commands at the bottom of the screen
set ruler                           " Show cursor position at the bottom
set showmode                        " Show the mode (insert/visu...)
set laststatus=1                    " Show the statusline if there are splits
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set splitbelow                      " Open horizontal splits below
set splitright                      " Open vertical splits on the right

set lazyredraw                      "redraw the screen only when it's needed
set autoread                        "periodically check if the file changed

set hlsearch        " Shows the last search pattern
set incsearch       " Highlight searches as the regex is typed
set ignorecase      " Ignore case when searching
set smartcase       " Don't ignore case when search pattern contains uppercase

set hidden          " Do not unload buffers when leaving them

set backspace=indent,eol,start      " backspace deletes indent, eol and stat
set matchpairs+=<:>

" Indentation settings are overriden by sleuth.vim
set smartindent     " Indents based on previous line indentation
set autoindent      " Indents when opening lines with o/O
set smarttab        " Indents by x chars instead of specific number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab       " Space-based indentation.
set shiftround      " When indenting with <> round to a multiple of shiftwidth

" set mouse=ar                  "enable mouse in terminal
set nocul                       "shows CursorLine
set nonu                        "shows line number

if has('folding')
  set foldmethod=indent         " Block folding is done with syntax
  set foldnestmax=10            " Fold a maximum of 10 blocks
  set nofoldenable              " Don't fold on file opening
endif

set viminfo+=n~/.vim/viminfo  " Set viminfo place

if !isdirectory($HOME . "/.vim/swapdir")
  call system("mkdir ~/.vim/swapdir")
endif
set dir=~/.vim/swapdir          " swp files will be saved in another directory

set undofile                " Enable persistent undo
if !isdirectory($HOME . "/.vim/undodir/")
  call system("mkdir ~/.vim/undodir/")
endif
set undodir=~/.vim/undodir  "sets the dir for cross-session undo
set undolevels=1000         "maximum number of changes that can be undone
set undoreload=10000        "maximum number lines to save for undo on a buffer reload

" set so=5 "There should be 5 lines between the cursor and end of screen

set noerrorbells    " No error bells
set novisualbell

set modeline        " Execute vim commands that are at the end of a file
set modelines=5     " Maximum number of lines that are checked for modeline

set updatetime=1000 " Updatetime is needed in order to refresh markology.vim

if 1
  set autochdir     " When changing buffer, move to directory containing the file

  let g:netrw_dirhistmax=0         " Do not write to ~/.vim/netrwist
  let g:netrw_banner=0             " Hide the filebrowser banner
  let g:netrw_browsex_viewer= "xdg-open" " Open files with xdg-open

  let g:tex_flavor = "latex"       " Sets which kind of latex I use
endif

