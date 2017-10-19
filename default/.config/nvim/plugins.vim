"Start Dein (plugin manager)
let s:config_dir = substitute(expand('<sfile>:p:h'), '\', '/', 'g')
let s:bundle_dir = s:config_dir . "/bundle"
let s:dein_dir = s:bundle_dir . "/repos/github.com/Shougo/dein.vim"
let s:do_update = 0

if !isdirectory(s:dein_dir)
	call mkdir(fnamemodify(s:dein_dir, "h"), "p")
	execute '!git clone --depth 1 --branch master "https://github.com/Shougo/dein.vim" "' . s:dein_dir . '"'
	let s:do_update = 1
endif
execute("set runtimepath+=" . s:dein_dir)

call dein#begin(s:bundle_dir)
call dein#add('https://github.com/Shougo/dein.vim')

" To be used everywhere, even in terminal
call dein#add('https://github.com/chrisbra/Recover.vim')
call dein#add('https://github.com/Shougo/denite.nvim')
call dein#add('https://github.com/Shougo/neomru.vim',                      {'depends': 'denite.nvim'})
call dein#add('https://github.com/haya14busa/incsearch.vim',               {'hook_add': '
	\ let g:incsearch#auto_nohlsearch = 1
	\| nmap / <Plug>(incsearch-forward)
	\| nmap ? <Plug>(incsearch-backward)
	\| nmap n <Plug>(incsearch-nohl-n)
	\| nmap N <Plug>(incsearch-nohl-N)'})

" New pending operators, functions and motions
call dein#add('https://github.com/tommcdo/vim-exchange',                   {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/tpope/vim-commentary.git',               {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/tpope/vim-repeat',                       {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/tpope/vim-surround')
call dein#add('https://github.com/wellle/targets.vim',                     {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/junegunn/vim-easy-align',                {'on_path': '^\(.*term:\/\/\)\@!.*$',
	\ 'hook_add': ' nmap ga <Plug>(EasyAlign)
	\| vmap ga <Plug>(EasyAlign)' })

" New text objects
call dein#add('https://github.com/kana/vim-textobj-user')
call dein#add('https://github.com/thinca/vim-textobj-between',             {'depends': 'vim-textobj-user'})
call dein#add('https://github.com/glts/vim-textobj-comment',               {'depends': 'vim-textobj-user'})
call dein#add('https://github.com/jceb/vim-textobj-uri',                   {'depends': 'vim-textobj-user'})
call dein#add('https://github.com/kana/vim-textobj-line',                  {'depends': 'vim-textobj-user'})
call dein#add('https://github.com/kana/vim-textobj-entire',                {'depends': 'vim-textobj-user'})
call dein#add('https://github.com/rbonvall/vim-textobj-latex',             {'depends': 'vim-textobj-user',
	\ 'hook_add': 'omap iE <Plug>(textobj-latex-environment-i)
	\| xmap iE <Plug>(textobj-latex-environment-i)
	\| omap aE <Plug>(textobj-latex-environment-a)
	\| xmap aE <Plug>(textobj-latex-environment-a)' })

" Autocompletion plugins
call dein#add('https://github.com/Shougo/deoplete.nvim',                   {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/Shougo/neoinclude.vim',                  {'depends': 'deoplete.nvim', 'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/zchee/deoplete-clang',                   {'depends': 'deoplete.nvim', 'on_ft': ['c', 'cpp']})
call dein#add('https://github.com/zchee/deoplete-go',                      {'depends': 'deoplete.nvim', 'on_ft': ['go'], 'build': {'unix': 'make'}})
call dein#add('https://github.com/zchee/deoplete-jedi',                    {'depends': 'deoplete.nvim', 'on_ft': ['python']})
" call dein#add('https://github.com/autozimu/LanguageClient-neovim',         {'depends': 'deoplete.nvim', 'on_ft': ['rust'],
" 	\ 'hook_add': 'let g:LanguageClient_serverCommands = {"rust": ["rustup", "run", "nightly", "rls"]}'})
call dein#add('https://github.com/carlitux/deoplete-ternjs',               {'depends': 'deoplete.nvim', 'on_ft': ['javascript']})
call dein#add('https://github.com/Shougo/neco-vim',                        {'depends': 'deoplete.nvim', 'on_ft': ['vim']})
call dein#add('https://github.com/zchee/deoplete-zsh',                     {'depends': 'deoplete.nvim', 'on_ft': ['sh', 'zsh'],
	\ 'hook_add': 'au FileType zsh au BufUnload <buffer> silent exec "!rm -f ~/.zcompdump_capture"'})

" Tags generation
call dein#add('https://github.com/ludovicchabant/vim-gutentags',           {'on_path': '^\(.*term:\/\/\)\@!.*$',
	\ 'hook_add': 'let s:xdg_data_home = $XDG_DATA_HOME
	\| if s:xdg_data_home == ""
	\|     let s:xdg_data_home = $HOME . "/.local/share"
	\| endif
	\| let s:tag_dir = s:xdg_data_home . "/nvim/tags"
	\| if !isdirectory(s:tag_dir)
	\|     call mkdir(s:tag_dir, "p")
	\| endif
	\| let g:gutentags_project_root = ["build.xml"]
	\| let g:gutentags_cache_dir = s:tag_dir'})

" Snippets plugins
call dein#add('https://github.com/Shougo/neosnippet.vim',                  {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/Shougo/neosnippet-snippets',             {'on_path': '^\(.*term:\/\/\)\@!.*$'})

" Automatically build files and show errors
call dein#add('https://github.com/neomake/neomake',                        {'on_path': '^\(.*term:\/\/\)\@!.*$',
	\ 'hook_add': "
	\ let g:neomake_error_sign    = {'text': '»', 'texthl': 'NeomakeErrorSign'}
	\| let g:neomake_warning_sign = {'text': '»', 'texthl': 'NeomakeWarningSign'}
	\| let g:neomake_message_sign = {'text': '»', 'texthl': 'NeomakeMessageSign'}
	\| let g:neomake_info_sign    = {'text': '»', 'texthl': 'NeomakeInfoSign'}
	\| let g:neomake_tex_enabled_makers = ['pdflatex']
	\| au BufWritePost * Neomake
	\| au User NeomakeFinished call UpdateLatexPdfDisplay()
	\ "})

" Echoes documentation in the command line when possible
call dein#add('https://github.com/Shougo/echodoc.vim',                     {'on_path': '^\(.*term:\/\/\)\@!.*$',
	    \ 'hook_add': 'let g:echodoc_enable_at_startup = 1'})

" Various language-specific plugins
call dein#add('https://github.com/let-def/vimbufsync',                     {'on_ft': ['coq']})
call dein#add('https://github.com/the-lambda-church/coquille',             {'on_ft': ['coq'],
	\ 'depends': 'vimbufsync',
	\ 'hook_add': "nnoremap <Leader>cn :CoqNext<CR>
		\ | nnoremap <Leader>cu :CoqUndo<CR>
		\ | nnoremap <Leader>ch :CoqToCursor<CR>"})
call dein#add('https://github.com/PotatoesMaster/i3-vim-syntax',           {'on_ft': ['i3']})
call dein#add('https://github.com/vim-erlang/vim-erlang-omnicomplete',     {'on_ft': ['erlang']})
call dein#add('https://github.com/jelera/vim-javascript-syntax',           {'on_ft': ['javascript']})
call dein#add('https://github.com/rust-lang/rust.vim',                     {'on_ft': ['rust']})
call dein#add('https://github.com/shiracamus/vim-syntax-x86-objdump-d',    {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/ap/vim-css-color',                       {'on_ft': ['css']})

" Completes 'if' with 'endif', opening brackets with closing brackets...
call dein#add('https://github.com/rstacruz/vim-closer.git',                {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#add('https://github.com/tpope/vim-endwise',                      {'on_ft': ['aspvbs', 'c', 'cpp', 'crystal', 'elixir', 'haskell', 'htmldjango', 'lua', 'matlab', 'objc', 'ruby', 'sh', 'snippets', 'vb', 'vbnet', 'vim', 'xdefaults', 'zsh']})

" Configures indentation settings
call dein#add('https://github.com/tpope/vim-sleuth.git',                   {'on_path': '^\(.*term:\/\/\)\@!.*$'})
call dein#end()

if s:do_update == 1
	call dein#update()
endif

" Denite
nnoremap Z :Denite buffer file_rec file_mru<CR>
nnoremap zh :Denite -default_action=split buffer file_rec file_mru<CR>
nnoremap zv :Denite -default_action=vsplit buffer file_rec file_mru<CR>
nnoremap zg :Denite grep:::!<CR>
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
" Add wildignored patterns to denite's ignored patterns
let wildignored_patterns = []
for elem in split(&wildignore, ',')
	let elem = substitute(elem, '*.', '*', 'g')
	let wildignored_patterns += ['--ignore', tolower(elem)]
	let wildignored_patterns += ['--ignore', toupper(elem)]
endfor
call denite#custom#var('file_rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '',
	\ '--ignore-dir', '.git/',    '--ignore-dir', '.hg/',          '--ignore-dir', '.bzr/',
	\ '--ignore-dir', '.svn/',    '--ignore-dir', 'undodir/',      '--ignore-dir', 'images/',
	\ '--ignore-dir', 'fonts/',   '--ignore-dir', 'music/',        '--ignore-dir', 'img/',
	\ '--ignore-dir', '.mozilla/','--ignore-dir', 'node_modules/', '--ignore-dir', 'img/',
	\ '--ignore-dir', 'bundle/',  '--ignore-dir', 'spell/',        '--ignore-dir', '.cache/',
	\ '--ignore-dir', 'swapdir/', '--ignore-dir', '.metadata/'] + wildignored_patterns)

" Deoplete && neosnippets
" <CR> when autocompleting creates a new line
function! s:my_cr_function() abort
	if exists('*deoplete#close_popup()')
		return deoplete#close_popup() . "\<CR>"
	endif
	return "\<CR>"
endfunction
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
imap <expr> <Tab> exists('*neosnippet#expandable_or_jumpable()') && neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<Tab>"
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_delay = 0
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
if !exists('g:deoplete#omni_patterns')
	let g:deoplete#omni_patterns = {}
end
let g:deoplete#omni_patterns.erlang = [
	\ '[^. *\t]:\w*',
	\ '^\s*-\w*'
	\ ]
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.erlang = 'erlang_complete#Complete'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:neosnippet#snippets_directory= [ s:config_dir . '/custom_snippets' , s:bundle_dir . '/repos/github.com/Shougo/neosnippet-snippets/neosnippets']
let g:deoplete#sources#clang#libclang_path="/usr/lib64/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/lib64/clang/"
let g:deoplete#sources#go#gocode_binary=$HOME . "/.gopath/bin/gocode"
