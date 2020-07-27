
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

" New pending operators, functions and motions
call minpac#add('https://github.com/tommcdo/vim-exchange')
call minpac#add('https://github.com/tpope/vim-repeat')
call minpac#add('https://github.com/tpope/vim-surround')
call minpac#add('https://github.com/wellle/targets.vim')
call minpac#add('https://github.com/junegunn/vim-easy-align')
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

" New text objects
call minpac#add('https://github.com/kana/vim-textobj-user')
call minpac#add('https://github.com/glts/vim-textobj-comment')
call minpac#add('https://github.com/kana/vim-textobj-entire')
call minpac#add('https://github.com/Julian/vim-textobj-variable-segment', {'branch':'main'})

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
call minpac#add('https://github.com/shumphrey/fugitive-gitlab.vim')
let g:fugitive_gitlab_domains = {'ssh://git@ssh.gitlab.adacore-it.com': 'https://gitlab.adacore-it.com'}

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
local function als_on_init(client)
	local path = client.workspace_folders[1].uri:sub(8)
	if vim.fn.filereadable(path .. "/database.gpr") ~= 0 then
		result = path .. "/database.gpr"
	elseif vim.fn.filereadable(path .. "/project_support.gpr") ~= 0 then
		result = path .. "/project_support.gpr"
	elseif vim.fn.filereadable(path .. "/wrappers.gpr") ~= 0 then
		result = path .. "/wrappers.gpr"
	elseif vim.fn.filereadable(path .. "/codepeer.gpr") ~= 0 then
		result = path .. "/codepeer.gpr"
	elseif vim.fn.filereadable(path .. "/codepeer_ws.gpr") ~= 0 then
		result = path .. "/codepeer_ws.gpr"
	elseif vim.fn.filereadable(path .. "/gnat2scil.gpr") ~= 0 then
		result = path .. "/gnat2scil.gpr"
	elseif vim.fn.filereadable(path .. "/world.gpr") ~= 0 then
		result = path .. "/world.gpr"
	elseif vim.fn.filereadable(path .. "/gnat.gpr") ~= 0 then
		result = path .. "/gnat.gpr"
	end
	if result ~= nil then
		client.config.settings.ada = { projectFile = result, log_level = 0 } 
		client.notify("workspace/didChangeConfiguration", client.config.settings)
	end
	return true
end
l.clangd.setup{ on_attach = setup_lsp_settings }
l.rust_analyzer.setup{ on_attach = setup_lsp_settings }
l.ocamllsp.setup{
	cmd = { "/home/lacambre/bin/ocaml-language-server/x86_64-linux/opam-4.11.2-0/install/repo/reloc/bin/ocamllsp" };
	on_attach = setup_lsp_settings
}
l.ts_ls.setup{ on_attach = setup_lsp_settings }
local configs = require("lspconfig.configs")
configs.ada_language_server = {
  default_config = {
    cmd = { 'ada_language_server' },
    filetypes = { 'ada' },
    root_dir = l.util.root_pattern('Makefile', '.git', '*.gpr', '*.adc'),
  },
}
l.ada_language_server.setup{
	cmd = { "/home/lacambre/bin/ada_language_server_wrapper" };
	on_attach = setup_lsp_settings;
	on_init = als_on_init;
	settings = {};
}
END

if s:do_update
	call minpac#update()
end
