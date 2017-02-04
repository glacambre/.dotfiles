set encoding=utf-8

set switchbuf=usetab,newtab         " Try to treat buffers as tabs
set tabpagemax=9                    " Have a maximum of 9 tabs open at all time
set showtabline=1                   " Show tabline when there are at least two
set tabline=%!MyTabLine()           " MyTabLine is defined in functions.vim

set wildmenu                        " Adds the menu at the bottom of the screen
set wildmode=list:longest,list:full " Wildmenu gives a list of all matches
set wildignore+=*.o,*.out,*.class   " Ignore certain filetypes
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

set autochdir                   " Automatically cd into dir of current buffer

set showcmd                     " Show commands at the bottom of the screen
set noruler                     " Don't show cursor position at the bottom
set noshowmode                  " Don't show the mode in the line at the bottom
set laststatus=1                " Always show the statusline
set statusline=%!MyStatusLine() " Defined in functions.vim
set splitbelow                  " Open horizontal splits below
set splitright                  " Open vertical splits on the right

set list
set listchars=eol:¬,tab:►\ 

set lazyredraw                  " Redraw the screen only when it's needed
set autoread                    " Periodically check if the file changed

set hlsearch   " Shows the last search pattern
set incsearch  " Highlight searches as the regex is typed
set ignorecase " Ignore case when searching
set smartcase  " Don't ignore case when search pattern contains uppercase
set gdefault   " Patterns match all matches on the same line by default

set hidden     " Do not unload buffers when leaving them

set backspace=indent,eol,start " backspace deletes indent, eol and stat
set matchpairs+=<:>

" Indentation settings are overriden by sleuth.vim
set smartindent   " Indents based on previous line indentation
set autoindent    " Indents when opening lines with o/O
set smarttab      " Indents by x chars instead of specific number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab     " Space-based indentation.
set shiftround    " When indenting with <> round to a multiple of shiftwidth

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

set updatetime=1000 " Updatetime is needed in order to refresh markology.vim

let g:netrw_dirhistmax=0               " Do not write to ~/.vim/netrwist
let g:netrw_banner=0                   " Hide the filebrowser banner
let g:netrw_browsex_viewer= "xdg-open" " Open files with xdg-open

let g:tex_flavor = "latex"             " Sets which kind of latex I use

