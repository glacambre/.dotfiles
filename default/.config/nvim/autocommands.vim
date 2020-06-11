
augroup MY_GENERAL_AUGROUP
	autocmd!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g`\"" | endif

	au BufUnload * wshada

	" This is equivalent to :set autochdir but lets buffer-local
	" autocommands change the dir. Autochdir doesn't.
	au BufEnter * if exists('b:shelley') && exists('b:shelley["path"]')
					\ | execute('lcd ' . b:shelley['path'])
				\ | else
					\ | let dir = expand('%:p:h')
					\ | if isdirectory(dir)
						\ | execute("lcd " . dir)
					\ | endif
				\ | endif
augroup END

augroup MY_UPDATE_AUGROUP
	autocmd!
	au BufWritePost ~/.config/xorg/Xdefaults !xrdb -merge ~/.config/xorg/Xdefaults
	au BufWritePost fonts.conf !fc-cache
augroup END

augroup MY_C_AUGROUP
	autocmd!
	au BufRead,BufNewFile *.h call GenerateCHeaderSkeleton()
augroup END

augroup MY_OCAML_AUGROUP
	autocmd!
	" Temporary, remove when https://github.com/vim/vim/issues/2428 is
	" closed
	au FileType ocaml setlocal commentstring=(*%s*)
augroup END

augroup MY_GIT_AUGROUP
	autocmd!
	au BufRead COMMIT_EDITMSG set ft=.gitcommit
augroup END

augroup MY_NETRW_AUGROUP
	autocmd!
	au FileType netrw call SetNetrwMappings()
augroup END

augroup MY_TERM_AUGROUP
	autocmd!
	au TermOpen * silent call OnTermOpen()
	au TermClose * nested silent call OnTermClose()
augroup END

augroup MY_MISC_AUGROUP
	autocmd!
	au BufReadPost *hledger.journal set ft=ledger
	au BufReadPost mutt-* setlocal formatoptions += aw | setlocal tw=78
augroup END

augroup MY_TEX_AUGROUP
	autocmd!
	au FileType tex setlocal spell spelllang=fr
	au FileType tex iabbrev <buffer> λ $\lambda$
	au FileType tex iabbrev <buffer> Λ $\Lambda$
	au FileType tex iabbrev <buffer> ß $\beta$
	au FileType tex iabbrev <buffer> Β $\Beta$
	au FileType tex iabbrev <buffer> γ $\gamma$
	au FileType tex iabbrev <buffer> Γ $\Gamma$
	au FileType tex iabbrev <buffer> π $\pi$
	au FileType tex iabbrev <buffer> Π $\Pi$
	au FileType tex iabbrev <buffer> τ $\tau$
	au FileType tex iabbrev <buffer> Τ $\Tau$
	au FileType tex iabbrev <buffer> μ $\mu$
	au FileType tex iabbrev <buffer> Μ $\Mu$
	au FileType tex iabbrev <buffer> → \rightarrow
	au FileType tex iabbrev <buffer> ⇒ \Rightarrow
	au FileType tex iabbrev <buffer> ← \leftarrow
	au FileType tex iabbrev <buffer> ⇐ \Leftarrow
	au FileType tex iabbrev <buffer> ↔ \leftrightarrow
	au FileType tex iabbrev <buffer> ⇔ \Leftrightarrow
augroup END

augroup MY_GNUPLOT_AUGROUP
	autocmd!
	au FileType gnuplot setlocal commentstring=#%s
augroup END

augroup MY_GCC_AUGROUP
	autocmd!
	au FileType c if stridx(expand("%:p"), '/gcc/') != -1 | call SetGCCStyle() | endif
augroup END

augroup MY_CSV_AUGROUP
	autocmd!
	au BufRead activity.csv call FillCSVLog()
	au BufRead breakfast.csv call FillCSVLog()
	au BufRead dinner.csv call FillCSVLog()
	au BufRead lunch.csv call FillCSVLog()
	au BufRead mood.csv call FillCSVLog()
	au BufRead sleep.csv call FillCSVLog()
augroup END
