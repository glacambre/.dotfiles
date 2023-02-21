
augroup MY_GENERAL_AUGROUP
	autocmd!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g`\"" | endif

	au BufUnload * wshada
augroup END

augroup MY_GIT_AUGROUP
	autocmd!
	au BufRead COMMIT_EDITMSG set ft=.gitcommit
augroup END

augroup MY_TERM_AUGROUP
	autocmd!
	au TermOpen * silent call OnTermOpen()
	au TermClose * nested silent call OnTermClose()
augroup END

augroup MY_GNUPLOT_AUGROUP
	autocmd!
	au FileType gnuplot setlocal commentstring=#%s
augroup END
