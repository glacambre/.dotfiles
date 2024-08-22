
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

augroup MY_GPR_AUGROUP
	autocmd!
	au BufRead,BufNewFile *.gpr if line('$') == 1 && getline(1) == ''
		\ |   let b:prjname = expand('%:t:r')
		\ |   if b:prjname == "agg"
		\ |     call append(line('$'), ["aggregate "])
		\ |   endif
		\ |   call append(line('$'), ["project " . b:prjname . " is"])
		\ |   if b:prjname == "agg"
		\ |     call append(line('$'), ["  for Project_Files use ();"])
		\ |   endif
		\ |   call append(line('$'), ["end " . b:prjname . ";"])
		\ |   call cursor(line('$') - 2, 9)
		\ | endif
augroup END

augroup MY_ADA_AUGROUP
	autocmd!
	au BufRead,BufNewFile *.adb if line('$') == 1 && getline(1) == ''
		\ |   let b:bodyname = expand('%:t:r')
		\ |   call append(line('$'), [
		\       "procedure " . b:bodyname . " is",
		\       "  A : Integer;",
		\       "begin",
		\       "  if A = 0 and then A = 1 then",
		\       "    null;",
		\       "  end if;",
		\       "end;"])
		\ |   call cursor(2, 11)
		\ | endif
augroup END
