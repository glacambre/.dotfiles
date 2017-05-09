
augroup MY_GENERAL_AUGROUP
	autocmd!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g`\"" | endif
	au CursorHold,FocusGained,FocusLost * rshada|wshada
augroup END

augroup MY_UPDATE_AUGROUP
	autocmd!
	au BufWritePost ~/.Xdefaults !xrdb -merge ~/.Xdefaults
	au BufWritePost fonts.conf !fc-cache
augroup END

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

augroup MY_NETRW_AUGROUP
	autocmd!
	au FileType netrw call SetNetrwMappings()
augroup END

augroup MY_TERM_AUGROUP
	autocmd!
	au TermOpen * silent call OnTermOpen()
	au TermClose * silent call OnTermClose()
augroup END

augroup MY_MISC_AUGROUP
	au FileType tex setlocal spell spelllang=fr
	au BufReadPost *hledger.journal set ft=ledger
	au BufReadPost mutt-* setlocal formatoptions += aw | setlocal tw=78
augroup END
