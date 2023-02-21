let s:config_dir = expand('<sfile>:p:h')
execute('source ' . s:config_dir . '/functions.vim')
execute('source ' . s:config_dir . '/settings.vim')
execute('source ' . s:config_dir . '/keymap.vim')
execute('source ' . s:config_dir . '/autocommands.vim')
execute('source ' . s:config_dir . '/plugins.vim')
set rtp+=/home/me/prog/firenvim/

lua <<EOF
vim.api.nvim_create_autocmd({ 'TermOSC' }, {
  callback = function(e)
    if vim.v.event.command == 7 then
      local dir = string.gsub(vim.v.event.payload, "file://[^/]*", "")
      if vim.fn.isdirectory(dir) == 0 then
        return
      end
      vim.api.nvim_buf_set_var(e.buf, "last_osc7_payload", dir)
      if vim.o.autochdir and vim.api.nvim_get_current_buf() == e.buf then
        vim.cmd.cd(dir)
      end
    end
  end
})
vim.api.nvim_create_autocmd({ 'dirchanged' }, {
  pattern = "auto",
  callback = function(e)
    if vim.b.last_osc7_payload ~= nil
      and vim.fn.isdirectory(vim.b.last_osc7_payload) == 1
    then
      vim.cmd.cd(vim.b.last_osc7_payload)
    end
  end
})
EOF
