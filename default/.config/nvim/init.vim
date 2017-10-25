execute("set titlestring=" . $NVIM_LISTEN_ADDRESS)
set title

let s:config_dir = expand('<sfile>:p:h')
execute("source " . s:config_dir . "/functions.vim")
execute("source " . s:config_dir . "/settings.vim")
execute("source " . s:config_dir . "/keymap.vim")
execute("source " . s:config_dir . "/autocommands.vim")
execute("source " . s:config_dir . "/plugins.vim")

colorscheme paramount

set exrc    " Enable project-specific vimrc
