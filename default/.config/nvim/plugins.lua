vim.pack.add({'https://github.com/kana/vim-submode'})
vim.g.submode_timeout = 0
vim.g.submode_always_show_submode = 1
vim.api.nvim_call_function('submode#enter_with', {'resize', 'n', '', '<C-w>r', '<Nop>'})
vim.api.nvim_call_function('submode#map', {'resize', 'n', '', 'h', '<C-w><'})
vim.api.nvim_call_function('submode#map', {'resize', 'n', '', 'j', '<C-w>+'})
vim.api.nvim_call_function('submode#map', {'resize', 'n', '', 'k', '<C-w>-'})
vim.api.nvim_call_function('submode#map', {'resize', 'n', '', 'l', '<C-w>>'})

vim.pack.add({'https://github.com/chrisbra/Recover.vim'})

-- New pending operators, functions and motions
vim.pack.add({'https://github.com/tommcdo/vim-exchange'})
vim.pack.add({'https://github.com/tpope/vim-repeat'})
vim.pack.add({'https://github.com/tpope/vim-surround'})
vim.pack.add({'https://github.com/wellle/targets.vim'})
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", {})
vim.pack.add({'https://github.com/junegunn/vim-easy-align'})

-- Completes 'if' with 'endif', opening brackets with closing brackets...
vim.pack.add({'https://github.com/kana/vim-textobj-user'})
vim.pack.add({'https://github.com/glts/vim-textobj-comment'})
vim.pack.add({'https://github.com/kana/vim-textobj-entire'})
vim.pack.add({{src = 'https://github.com/Julian/vim-textobj-variable-segment', {version = 'main'}}})

-- Completes 'if' with 'endif', opening brackets with closing brackets...
vim.pack.add({'https://github.com/rstacruz/vim-closer.git'})
vim.pack.add({'https://github.com/tpope/vim-endwise'})

-- Configures indentation settings
vim.pack.add({'https://github.com/tpope/vim-sleuth.git'})

-- Git gud
vim.pack.add({'https://github.com/tpope/vim-fugitive'})
vim.pack.add({'https://github.com/shumphrey/fugitive-gitlab.vim'})
vim.g.fugitive_gitlab_domains = {['ssh://git@ssh.gitlab.adacore-it.com']= 'https://gitlab.adacore-it.com'}

vim.pack.add({'https://github.com/neovim/nvim-lspconfig'})
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

function setup_autoformat (client, buf)
  if not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
      end,
    })
  end
end

l.clangd.setup{ on_attach = setup_lsp_settings }
l.rust_analyzer.setup{ on_attach = setup_lsp_settings }
l.ocamllsp.setup{ on_attach = function (client, buf)
  setup_autoformat(client, buf)
  setup_lsp_settings(client, buf)
end }

vim.diagnostic.config({ virtual_lines = true })
