
let s:do_update = v:false
try
	packadd minpac
catch
	exe '!git clone https://github.com/k-takata/minpac.git ' . stdpath('config') . '/pack/minpac/opt/minpac'
	packadd minpac
	let s:do_update = v:true
endtry

call minpac#init()

call minpac#add('https://github.com/k-takata/minpac')

" Enhance terminal
call minpac#add('https://github.com/glacambre/shelley')
nnoremap <silent> <expr> <Space>b shelley#PrevPrompt()
vnoremap <silent> <expr> <Space>b shelley#PrevPrompt()
nnoremap <silent> <expr> <Space>a shelley#NextPrompt()
vnoremap <silent> <expr> <Space>a shelley#NextPrompt()

" To be used everywhere, even in terminal
call minpac#add('https://github.com/kana/vim-submode')
function SetupResizeSubmode() abort
	let g:submode_timeout = 0
	let g:submode_always_show_submode = 1
	call submode#enter_with('resize', 'n', '', '<C-w>r', '<Nop>')
	call submode#map('resize', 'n', '', 'h', '<C-w><')
	call submode#map('resize', 'n', '', 'j', '<C-w>+')
	call submode#map('resize', 'n', '', 'k', '<C-w>-')
	call submode#map('resize', 'n', '', 'l', '<C-w>>')
	call nvim_input('<C-w>r')
endfunction
nnoremap <C-w>r <Cmd>call SetupResizeSubmode()<CR>

call minpac#add('https://github.com/chrisbra/Recover.vim')

call minpac#add('https://github.com/Shougo/denite.nvim')
function! SetupDenite(key)
	call denite#custom#option("default", { "start_filter": 1, "split": "floating" })
	nnoremap Z  <Cmd>Denite buffer file/rec file_mru<CR>
	nnoremap zh <Cmd>Denite -default_action=split buffer file/rec file_mru<CR>
	nnoremap zv <Cmd>Denite -default_action=vsplit buffer file/rec file_mru<CR>
	nnoremap zg <Cmd>Denite grep:::!<CR>
	nnoremap zt <Cmd>Denite outline<CR>
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
	function! Setup_denite_mappings()
		inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
		inoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
		inoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
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
	call nvim_input(a:key)
endfunction
nnoremap Z  <Cmd>call SetupDenite("Z")<CR>
nnoremap zh <Cmd>call SetupDenite("zh")<CR>
nnoremap zv <Cmd>call SetupDenite("zv")<CR>
nnoremap zg <Cmd>call SetupDenite("zg")<CR>
nnoremap zt <Cmd>call SetupDenite("zt")<CR>

call minpac#add('https://github.com/Shougo/neomru.vim')

" New pending operators, functions and motions
call minpac#add('https://github.com/tommcdo/vim-exchange')
call minpac#add('https://github.com/tpope/vim-commentary.git')
call minpac#add('https://github.com/tpope/vim-repeat')
call minpac#add('https://github.com/tpope/vim-surround')
call minpac#add('https://github.com/wellle/targets.vim')
call minpac#add('https://github.com/junegunn/vim-easy-align')
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

" New text objects
call minpac#add('https://github.com/kana/vim-textobj-user')
call minpac#add('https://github.com/thinca/vim-textobj-between')
call minpac#add('https://github.com/glts/vim-textobj-comment')
call minpac#add('https://github.com/kana/vim-textobj-entire')
call minpac#add('https://github.com/Julian/vim-textobj-variable-segment')
call minpac#add('https://github.com/rbonvall/vim-textobj-latex')
omap iE <Plug>(textobj-latex-environment-i)
xmap iE <Plug>(textobj-latex-environment-i)
omap aE <Plug>(textobj-latex-environment-a)
xmap aE <Plug>(textobj-latex-environment-a)

" Vim-polyglot
let g:polyglot_disabled = ["graphql"]
let g:LatexBox_no_mappings = 1
call minpac#add('https://github.com/sheerun/vim-polyglot')
call minpac#add('https://github.com/shiracamus/vim-syntax-x86-objdump-d')

" Completes 'if' with 'endif', opening brackets with closing brackets...
call minpac#add('https://github.com/rstacruz/vim-closer.git')
call minpac#add('https://github.com/tpope/vim-endwise')

" Configures indentation settings
call minpac#add('https://github.com/tpope/vim-sleuth.git')

" Git gud
call minpac#add('https://github.com/tpope/vim-fugitive')

" Default LSP configs
call minpac#add('https://github.com/neovim/nvim-lspconfig')
packadd nvim-lspconfig
lua << END
local l = require("lspconfig")
local function nnoremap(keys, command)
	vim.api.nvim_command("nnoremap <buffer> <silent> " .. keys
		.. " <cmd>lua " .. command .. "()<CR>")
end
local function setup_lsp_settings(client, buf)
	local opts = { noremap=true, silent=true }
	vim.api.nvim_buf_set_keymap(buf, "n", "gd",        "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<c-]>",     "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "gD",        "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<c-k>",     "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "1gD",       "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "gr",        "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "g0",        "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<Space>ld", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<C-r>",     ":lua vim.lsp.buf.rename('')<Left><Left>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<C-n>",     "<C-x><C-o><C-n>", opts)
	vim.api.nvim_buf_set_option(buf, "omnifunc",  "v:lua.vim.lsp.omnifunc")
end
l.clangd.setup{ on_attach = setup_lsp_settings }
l.tsserver.setup{ on_attach = setup_lsp_settings }
l.als.setup{ on_attach = setup_lsp_settings }
l.rust_analyzer.setup{ on_attach = setup_lsp_settings }
END

if s:do_update
	call minpac#update()
end
