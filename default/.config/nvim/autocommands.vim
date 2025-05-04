
augroup MY_GENERAL_AUGROUP
	autocmd!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g`\"" | endif

	au BufUnload * wshada
augroup END

augroup MY_OCAML_AUGROUP
	autocmd!
	" Temporary, remove when https://github.com/vim/vim/issues/2428 is
	" closed
	au FileType ocaml setlocal commentstring=(*%s*)

	au BufWritePre *.ml if empty(v:lua.vim.lsp.get_clients()) && executable("ocamlformat") | execute "normal! m'" | silent! execute "%!ocamlformat --enable-outside-detected-project --name % -"  | if v:shell_error | undo | else | execute "normal! ''" | end | end
	au BufWritePre *.mli if empty(v:lua.vim.lsp.get_clients()) && executable("ocamlformat") | execute "normal! m'" | silent! execute "%!ocamlformat --enable-outside-detected-project --name % -"  | if v:shell_error | undo | else | execute "normal! ''" | end | end

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
