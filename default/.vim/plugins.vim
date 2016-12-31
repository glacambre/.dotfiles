if 1
  "Starts the plugin manager
  execute pathogen#infect()
  Helptags

  "Adds syntastic info to status line.
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  "Sets syntastic conf.
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  "Sets trailing whitespace color to purple
  highlight ShowTrailingWhitespace ctermbg=135 guibg=135

  "Use <C-r> to toggle the history tree
  noremap <C-r> :UndotreeToggle<CR>:UndotreeFocus<CR>
  function g:Undotree_CustomMap()
    nmap <buffer> <C-r> :UndotreeToggle<CR>
  endfunction

  " Easy align : select text, return, space, return
  vnoremap <silent> <Enter> :EasyAlign<cr>

  " AutoComplPop
  au BufEnter *.tex AcpDisable
  au BufLeave *.tex AcpEnable

endif
