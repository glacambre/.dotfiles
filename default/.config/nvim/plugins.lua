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
vim.pack.add({'https://github.com/Julian/vim-textobj-variable-segment'})

-- Completes 'if' with 'endif', opening brackets with closing brackets...
vim.pack.add({'https://github.com/rstacruz/vim-closer.git'})
vim.pack.add({'https://github.com/tpope/vim-endwise'})

-- Configures indentation settings
vim.pack.add({'https://github.com/tpope/vim-sleuth.git'})

-- Git gud
vim.pack.add({'https://github.com/tpope/vim-fugitive'})
vim.pack.add({'https://github.com/barrettruth/diffs.nvim'})
vim.pack.add({'https://github.com/shumphrey/fugitive-gitlab.vim'})
vim.g.fugitive_gitlab_domains = {['ssh://git@ssh.gitlab.adacore-it.com']= 'https://gitlab.adacore-it.com'}
-- User command to edit/review the currently unstaged changes
vim.api.nvim_create_user_command('GdiffAll', function(opts)
  local ref = opts.args ~= '' and opts.args or nil

  local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 or not root or root == '' then
    vim.notify('Not inside a git repository', vim.log.levels.ERROR)
    return
  end

  local diff_cmd = { 'git', '-C', root, 'diff', '--name-only' }
  if ref then
    table.insert(diff_cmd, 4, ref) -- git diff <ref> --name-only
  end

  local files = vim.fn.systemlist(diff_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('git diff failed (bad ref: ' .. (ref or '') .. '?)', vim.log.levels.ERROR)
    return
  end

  for _, f in ipairs(files) do
    if f ~= '' then
      local abs_path = root .. '/' .. f
      vim.cmd('tabedit ' .. vim.fn.fnameescape(abs_path))
      if ref then
        vim.cmd('Gdiffsplit ' .. ref)
      else
        vim.cmd('Gdiffsplit')
      end
    end
  end
end, {
  nargs = '?',
  complete = function()
    return vim.fn.systemlist('git branch --format=%(refname:short)')
  end,
})

vim.pack.add({'https://github.com/neovim/nvim-lspconfig'})

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
	vim.api.nvim_buf_set_keymap(buf, "n", "<Space>ld", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<C-r>",     ":lua vim.lsp.buf.rename('')<Left><Left>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<C-n>",     "<C-x><C-o><C-n>", opts)
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = buf })
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

vim.lsp.config('ada_ls', {
       cmd = { "/home/lacambre/bin/ada_language_server_wrapper" };
       on_attach = setup_lsp_settings;
       on_init = als_on_init;
       settings = {};
})
vim.api.nvim_create_user_command('Gpr', function(opts) vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = { ada = { projectFile = table.concat(opts.fargs) } } } ) end, { nargs = 1 })

vim.lsp.config('clangd', { on_attach = setup_lsp_settings })
vim.lsp.config('rust_analyzer', { on_attach = setup_lsp_settings })
vim.lsp.config('ocamllsp', { on_attach = function (client, buf)
  setup_autoformat(client, buf)
  setup_lsp_settings(client, buf)
end })
vim.lsp.enable({ 'clangd', 'rust_analyzer', 'ocamllsp', 'ada_ls' })

vim.diagnostic.config({ virtual_lines = true })
