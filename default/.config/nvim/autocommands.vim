au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif

au BufWritePost ~/.Xdefaults !xrdb -merge ~/.Xdefaults
au BufWritePost fonts.conf !fc-cache

" au BufWritePost *.tex call CompileAndUpdate()
au FileType tex setlocal spell spelllang=fr

au BufReadPost *hledger.journal set ft=ledger

augroup MY_C_AUGROUP
	autocmd!
	" When reading a .h file, if it is empty, add a generic include guard
	" Also, set its ft to c.
	au BufRead,BufNewFile *.h if line('$') == 1 && getline(1) == ''
		\ | let b:definevar = substitute(toupper(expand('%:t')), "\\.", "_", "g")
		\ | call append(0, ["#ifndef " . b:definevar, "#define " . b:definevar, "", "#endif"])
		\ | call cursor(line('$') - 2, 1)
		\ | endif
		\ | set ft=c
augroup END

au BufReadPost mutt-* setlocal formatoptions += aw | setlocal tw=78

au FileType netrw call SetNetrwMappings()

au TermOpen * silent call OnTermOpen()
au TermClose * silent call OnTermClose()

autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
