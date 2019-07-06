let s:config_dir = expand('<sfile>:p:h')
execute("source " . s:config_dir . "/functions.vim")
execute("source " . s:config_dir . "/settings.vim")
execute("source " . s:config_dir . "/keymap.vim")
execute("source " . s:config_dir . "/autocommands.vim")
execute("source " . s:config_dir . "/plugins.vim")
set rtp+=/home/me/prog/firenvim/

filetype plugin indent on
syntax enable
colorscheme paramount
set bg=light

set exrc    " Enable project-specific vimrc
