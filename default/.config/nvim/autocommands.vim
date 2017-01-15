au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif

au BufWritePost ~/.Xdefaults !xrdb -merge ~/.Xdefaults
au BufWritePost fonts.conf !fc-cache

au BufWritePost *.tex call CompileAndUpdate()
au FileType tex setlocal spell spelllang=fr

au BufReadPost *hledger.journal set ft=ledger

au BufReadPost *.h,*.c set ft=c

au BufReadPost mutt-* setlocal formatoptions += aw | setlocal tw=78

au FileType netrw call SetNetrwMappings()

au FileType calendar call ShowTrailingWhitespace#Set(0,0)

au TermOpen * silent call OnTermOpen()
au TermClose * silent call OnTermClose()

autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
