local config_dir = vim.fn.expand('<sfile>:p:h')
vim.cmd.source(config_dir .. '/functions.vim')
vim.cmd.source(config_dir .. '/settings.vim')
vim.cmd.source(config_dir .. '/keymap.vim')
vim.cmd.source(config_dir .. '/autocommands.vim')
vim.cmd.source(config_dir .. '/plugins.vim')
vim.opt.rtp:append('/home/me/prog/firenvim/')

if vim.g.started_by_firenvim then
  vim.g.firenvim_config = {
    localSettings = {
      ['app.element.io'] = {
        takeover = 'never',
      },
    },
  }
  local max_height = 10
  local id = vim.api.nvim_create_augroup("ExpandLinesOnTextChanged", { clear = true })
  vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
    group = id,
    callback = function(ev)
      local height = vim.api.nvim_win_text_height(0, {}).all
      if height > vim.o.lines and height < max_height then
        vim.o.lines = height
      end
    end
  })
end

function onTermRequest(e)
  if string.sub(vim.v.termrequest, 1, 4) == "\x1b]7;" then
    local dir = string.gsub(vim.v.termrequest, "\x1b]7;file://[^/]*", "")
    if vim.fn.isdirectory(dir) == 0 then
      return
    end
    vim.api.nvim_buf_set_var(e.buf, "last_osc7_payload", dir)
    if vim.o.autochdir and vim.api.nvim_get_current_buf() == e.buf then
      vim.cmd.cd(vim.fn.fnameescape(dir))
    end
  end
end

function triggerTermAutochdir(e)
  if vim.o.autochdir
    and vim.b.last_osc7_payload ~= nil
    and vim.fn.isdirectory(vim.b.last_osc7_payload) == 1
    then
    vim.cmd.cd(vim.fn.fnameescape(vim.b.last_osc7_payload))
  end
end

vim.api.nvim_create_autocmd({ 'TermRequest' }, { callback = onTermRequest })
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'DirChanged' }, { callback = triggerTermAutochdir })
