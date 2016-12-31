if has("autocmd")
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline

  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif

  au BufWritePost ~/.Xdefaults !xrdb -merge ~/.Xdefaults
  au BufWritePost fonts.conf !fc-cache

  au BufWritePost *.tex call CompileAndUpdate()
  au FileType tex setlocal spell spelllang=fr

  au BufReadPost *hledger.journal set ft=ledger

  au BufEnter mutt-* setlocal formatoptions += aw

  au FileType netrw call SetNetrwMappings()

  au FileType calendar call ShowTrailingWhitespace#Set(0,0)

endif
