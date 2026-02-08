local config_dir = vim.fn.expand('<sfile>:p:h')
vim.cmd.source(config_dir .. '/functions.vim')
vim.cmd.source(config_dir .. '/settings.vim')
vim.cmd.source(config_dir .. '/keymap.vim')
vim.cmd.source(config_dir .. '/autocommands.vim')
vim.cmd.source(config_dir .. '/plugins.lua')
vim.opt.rtp:append('/home/me/prog/firenvim/')

if vim.g.started_by_firenvim then
  vim.g.firenvim_config = {
    localSettings = {
      ['app.element.io'] = {
        takeover = 'never',
      },
      ['slack.com'] = {
        takeover = 'never',
      },
      ['sheets.google.com'] = {
        takeover = 'never',
      },
      ['docs.google.com'] = {
        takeover = 'never',
      },
      ['slides.google.com'] = {
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
      if height > vim.o.lines then
        if height < max_height then
          vim.o.lines = height
        else
          vim.o.lines = max_height
        end
      end
    end
  })
end

function termBufName(bid)
  local success, last_osc7_payload = pcall(function()
    return vim.api.nvim_buf_get_var(bid, "last_osc7_payload")
  end)
  if success and last_osc7_payload ~= nil then
    local dir = vim.fn.fnameescape(last_osc7_payload)
    local chan = vim.bo[bid].channel
    local pid = vim.fn.jobpid(chan)
    -- argv always starts with '&shell -c', so slice it to remove that part
    local args = vim.api.nvim_get_chan_info(chan).argv
    if args[1] == vim.o.shell and args[2] == "-c" then
      args = vim.list_slice(args, 3)
    end
    local result = "term:" .. dir .. "//" .. pid .. ":" .. table.concat(args, " ")
    return result
  end
  return nil
end

function onTermRequest(e)
  if string.sub(vim.v.termrequest, 1, 4) == "\x1b]7;" then
    local dir = string.gsub(vim.v.termrequest, "\x1b]7;file://[^/]*", "")
    if vim.fn.isdirectory(dir) == 0 then
      return
    end
    vim.api.nvim_buf_set_var(e.buf, "last_osc7_payload", dir)
    local bid = vim.api.nvim_get_current_buf()
    if vim.o.autochdir and bid == e.buf then
      vim.cmd.cd(vim.fn.fnameescape(dir))
      local success, last_osc7_payload = pcall(function()
        return vim.api.nvim_buf_get_var(bid, "last_osc7_payload")
      end)
      if success then
        local name = termBufName(bid)
        if name ~= nil then
          vim.cmd.file(name)
        end
      end
    end
  end
end

function triggerTermAutochdir(e)
  if not vim.o.autochdir then
    return
  end
  local bid = vim.api.nvim_get_current_buf()
  local success, last_osc7_payload = pcall(function()
    return vim.api.nvim_buf_get_var(bid, "last_osc7_payload")
  end)
  if success
    and last_osc7_payload ~= nil
    and vim.fn.isdirectory(last_osc7_payload) == 1
    then
    local dir = vim.fn.fnameescape(last_osc7_payload)
    vim.cmd.cd(dir)
    local name = termBufName(bid)
    if name ~= nil then
      vim.cmd.file(name)
    end
  end
end

vim.api.nvim_create_autocmd({ 'TermRequest' }, { callback = onTermRequest })
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'DirChanged' }, { callback = triggerTermAutochdir })
