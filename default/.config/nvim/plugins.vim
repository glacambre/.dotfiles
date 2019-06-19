" First, setup global variables
let s:config_dir = substitute(expand('<sfile>:p:h'), '\', '/', 'g')
let s:bundle_dir = s:config_dir . "/bundle"
let s:dein_dir = s:bundle_dir . "/repos/github.com/Shougo/dein.vim"
let s:do_update = 0

" Vim-polyglot
let g:polyglot_disabled = ["graphql"]

" Neosnippet
let g:neosnippet#snippets_directory= [s:config_dir . '/custom_snippets', s:bundle_dir . '/repos/github.com/Shougo/neosnippet-snippets/neosnippets']

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#sources#clang#libclang_path=system("find /usr/lib/ -name '*libclang.so*' -print -quit")[0:-2]
let g:deoplete#sources#clang#clang_header="/usr/lib/clang/"
let g:deoplete#sources#go#gocode_binary=$HOME . "/.gopath/bin/gocode"
function! Deoplete_cr() abort
	return deoplete#close_popup() . "\<CR>"
endfunction

" Denite
function! Setup_denite_ignores()
	" Add wildignored patterns to denite's ignored patterns
	let wildignored_patterns = []
	for elem in split(&wildignore, ',')
		let wildignored_patterns += ['-iname', elem, '-prune', '-o']
	endfor
	let wildignored_patterns = ['find', '-L', ':directory', '-type', 'd', '!', '-executable', '-prune', '-o',
				\  '-path', '*/.git/*',         '-prune', '-o', '-path', '*/.hg/*',      '-prune', '-o',
				\  '-path', '*/.bzr/*',         '-prune', '-o', '-path', '*/.svn/*',     '-prune', '-o',
				\  '-path', '*/undodir/*',      '-prune', '-o', '-path', '*/images/*',   '-prune', '-o',
				\  '-path', '*/fonts/*',        '-prune', '-o', '-path', '*/music/*',    '-prune', '-o',
				\  '-path', '*/img/*',          '-prune', '-o', '-path', '*/.mozilla/*', '-prune', '-o',
				\  '-path', '*/node_modules/*', '-prune', '-o', '-path', '*/img/*',      '-prune', '-o',
				\  '-path', '*/bundle/*',       '-prune', '-o', '-path', '*/spell/*',    '-prune', '-o',
				\  '-path', '*/.cache/*',       '-prune', '-o', '-path', '*/swapdir/*',  '-prune', '-o',
				\  '-path', '*/.metadata/*',    '-prune', '-o', '-path', '*/.Private/*', '-prune', '-o'] +
				\ wildignored_patterns + ['-type', 'f', '-print']
	call denite#custom#var('file/rec', 'command', wildignored_patterns)
endfunction

function! Setup_denite_settings()
	call Setup_denite_ignores()
	function! Setup_denite_mappings()
		call deoplete#custom#buffer_option("auto_complete", v:false)
		inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
		inoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
		inoremap <silent><buffer> <C-n> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
		inoremap <silent><buffer> <C-p> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
		inoremap <silent><buffer> <C-a> <Home>
		inoremap <silent><buffer> <C-e> <End>
		inoremap <silent><buffer> <C-h> <Left>
		inoremap <silent><buffer> <C-j> <Down>
		inoremap <silent><buffer> <C-k> <Up>
		inoremap <silent><buffer> <C-l> <Right>
	endfunction
	autocmd FileType denite-filter call Setup_denite_mappings()
endfunction

" If dein isn't already there, install it
if !isdirectory(s:dein_dir)
	call mkdir(fnamemodify(s:dein_dir, "h"), "p")
	execute '!git clone --depth 1 --branch master "https://github.com/Shougo/dein.vim" "' . s:dein_dir . '"'
	let s:do_update = 1
endif
execute("set runtimepath+=" . s:dein_dir)

if dein#load_state(s:bundle_dir)
	call dein#begin(s:bundle_dir)
	call dein#add('https://github.com/Shougo/dein.vim',   {'hook_done_update': 'execute "UpdateRemotePlugins"'})

	" Enhance terminal
	call dein#add('https://github.com/glacambre/shelley', {'hook_add': '
				\  nnoremap <silent> <expr> <Space>b shelley#PrevPrompt()
				\| vnoremap <silent> <expr> <Space>b shelley#PrevPrompt()
				\| nnoremap <silent> <expr> <Space>a shelley#NextPrompt()
				\| vnoremap <silent> <expr> <Space>a shelley#NextPrompt()'})

	" To be used everywhere, even in terminal
	call dein#add('https://github.com/kana/vim-submode',             {'hook_add': "
				\  let g:submode_timeout = 0
				\| let g:submode_always_show_submode = 1
				\| call submode#enter_with('resize', 'n', '', '<C-r>', '<Nop>')
				\| call submode#map('resize', 'n', '', 'h', '<C-w><')
				\| call submode#map('resize', 'n', '', 'j', '<C-w>+')
				\| call submode#map('resize', 'n', '', 'k', '<C-w>-')
				\| call submode#map('resize', 'n', '', 'l', '<C-w>>')
				\"})
	call dein#add('https://github.com/chrisbra/Recover.vim')
	call dein#add('https://github.com/Shougo/denite.nvim',           {'hook_add': '
				\  call denite#custom#option("default", { "start_filter": 1, "split": "floating" })
				\| execute("nnoremap Z  :Denite buffer file/rec file_mru<CR>")
				\| execute("nnoremap zh :Denite -default_action=split buffer file/rec file_mru<CR>")
				\| execute("nnoremap zv :Denite -default_action=vsplit buffer file/rec file_mru<CR>")
				\| execute("nnoremap zg :Denite grep:::!<CR>")
				\| execute("nnoremap zt :Denite outline<CR>")
				\| call Setup_denite_settings()
				\|'})
	call dein#add('https://github.com/Shougo/neomru.vim',            {'depends': 'denite.nvim'})

	" New pending operators, functions and motions
	call dein#add('https://github.com/tommcdo/vim-exchange')
	call dein#add('https://github.com/tpope/vim-commentary.git')
	call dein#add('https://github.com/tpope/vim-repeat')
	call dein#add('https://github.com/tpope/vim-surround')
	call dein#add('https://github.com/wellle/targets.vim')
	call dein#add('https://github.com/junegunn/vim-easy-align', {'hook_add': 'nmap ga <Plug>(EasyAlign) | vmap ga <Plug>(EasyAlign)' })

	" New text objects
	call dein#add('https://github.com/kana/vim-textobj-user')
        call dein#add('https://github.com/thinca/vim-textobj-between',          {'depends': 'vim-textobj-user'})
        call dein#add('https://github.com/glts/vim-textobj-comment',            {'depends': 'vim-textobj-user'})
        call dein#add('https://github.com/kana/vim-textobj-entire',             {'depends': 'vim-textobj-user'})
        call dein#add('https://github.com/Julian/vim-textobj-variable-segment', {'depends': 'vim-textobj-user'})
        call dein#add('https://github.com/rbonvall/vim-textobj-latex',          {'depends': 'vim-textobj-user', 'hook_add': '
				\  omap iE <Plug>(textobj-latex-environment-i)
				\| xmap iE <Plug>(textobj-latex-environment-i)
				\| omap aE <Plug>(textobj-latex-environment-a)
				\| xmap aE <Plug>(textobj-latex-environment-a)'})

	" Autocompletion plugins
	call dein#add('https://github.com/Shougo/deoplete.nvim',     {'on_path': '^\(.*term:\/\/\)\@!.*$', 'hook_add': 'inoremap <silent> <CR> <C-r>=Deoplete_cr()<CR>'})
	call dein#add('https://github.com/Shougo/neoinclude.vim',    {'depends': 'deoplete.nvim', 'on_path': '^\(.*term:\/\/\)\@!.*$'})
	call dein#add('https://github.com/zchee/deoplete-clang',     {'depends': 'deoplete.nvim', 'on_ft': ['c', 'cpp']})
	call dein#add('https://github.com/zchee/deoplete-jedi',      {'depends': 'deoplete.nvim', 'on_ft': ['python']})
	call dein#add('https://github.com/carlitux/deoplete-ternjs', {'depends': 'deoplete.nvim', 'on_ft': ['javascript']})
	call dein#add('https://github.com/Shougo/neco-vim',          {'depends': 'deoplete.nvim', 'on_ft': ['vim']})
	call dein#add('https://github.com/zchee/deoplete-zsh',       {'depends': 'deoplete.nvim', 'on_ft': ['sh', 'zsh'],
				\ 'hook_add': 'au FileType zsh au BufUnload <buffer> silent exec "!rm -f ~/.zcompdump_capture"'})

	" Tags generation
	call dein#add('https://github.com/ludovicchabant/vim-gutentags', {
				\ 'if': 'executable("ctags")',
				\ 'hook_add': '
				\  let s:xdg_data_home = $XDG_DATA_HOME
				\| if s:xdg_data_home == ""
				\|     let s:xdg_data_home = $HOME . "/.local/share"
				\| endif
				\| let s:tag_dir = s:xdg_data_home . "/nvim/tags"
				\| if !isdirectory(s:tag_dir)
				\|     call mkdir(s:tag_dir,             "p")
				\| endif
				\| let g:gutentags_project_root = ["build.xml"]
				\| let g:gutentags_cache_dir = s:tag_dir'})

	" Snippets plugins
	call dein#add('https://github.com/Shougo/neosnippet.vim', {'hook_add': "
				\  execute(\"imap <expr> <Tab> neosnippet#expandable_or_jumpable() ? '\\<Plug>(neosnippet_jump_or_expand)' : '\\<Tab>'\")
				\| let g:neosnippet#disable_runtime_snippets = {'_' : 1}"})
	call dein#add('https://github.com/Shougo/neosnippet-snippets')

	" Automatically build files and show errors
	call dein#add('https://github.com/neomake/neomake', {'hook_add': "
				\  let g:neomake_error_sign   = {'text': '»', 'texthl': 'NeomakeErrorSign'}
				\| let g:neomake_warning_sign = {'text': '»', 'texthl': 'NeomakeWarningSign'}
				\| let g:neomake_message_sign = {'text': '»', 'texthl': 'NeomakeMessageSign'}
				\| let g:neomake_info_sign    = {'text': '»', 'texthl': 'NeomakeInfoSign'}
				\| let g:neomake_tex_enabled_makers = ['pdflatex']
				\| au BufWritePost * Neomake
				\| au User NeomakeFinished call UpdateLatexPdfDisplay()"})

	" Echoes documentation in the command line when possible
	call dein#add('https://github.com/Shougo/echodoc.vim', {'hook_add': 'let g:echodoc_enable_at_startup = 1'})

	" Various language-specific plugins
	call dein#add('https://github.com/sheerun/vim-polyglot', {'hook_add': 'let g:LatexBox_no_mappings = 1'})
	call dein#add('https://github.com/shiracamus/vim-syntax-x86-objdump-d')
	call dein#add('https://github.com/ap/vim-css-color')

	" Completes 'if' with 'endif', opening brackets with closing brackets...
	call dein#add('https://github.com/rstacruz/vim-closer.git')
	call dein#add('https://github.com/tpope/vim-endwise')

	" Configures indentation settings
	call dein#add('https://github.com/tpope/vim-sleuth.git')

	" Rainbow parentheses
	call dein#add('https://github.com/kien/rainbow_parentheses.vim', {'hook_add': 'au BufEnter *.{clj,cljc} execute("RainbowParenthesesActivate") 
				\| execute("RainbowParenthesesLoadRound")
				\| execute("RainbowParenthesesLoadSquare")'})

	" Git gud
	call dein#add('https://github.com/tpope/vim-fugitive', {'on_path': '^\(.*term:\/\/\)\@!.*$'})

	call dein#end()
	call dein#save_state()
endif

if s:do_update
	call dein#update()
endif
