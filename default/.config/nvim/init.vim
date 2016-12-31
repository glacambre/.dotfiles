let s:config_dir = expand('<sfile>:p:h')
execute("source " . s:config_dir . "/functions.vim")
execute("source " . s:config_dir . "/settings.vim")
execute("source " . s:config_dir . "/keymap.vim")
execute("source " . s:config_dir . "/autocommands.vim")

set secure  " Disable dangerous settings, just in case
set exrc    " Enable project-specific vimrc

execute("source " . s:config_dir . "/plugins.vim")
if has('autocmd')
    filetype plugin indent on " filetype detection
endif
if has('syntax')
  syntax on                 " syntax highlighting
  colorscheme paramount     " sets theme
  set background=dark       " Dark background
endif
