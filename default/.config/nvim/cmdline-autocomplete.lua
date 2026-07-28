-- fuzzy file picker/command completion based on `:h fuzzy-file-picker`
local augroup = vim.api.nvim_create_augroup("cmdline_fuzzy", { clear = true })

vim.o.wildmode = "noselect:lastused,full"

local exclude_dirs = {".nyc_output", "node_modules", "build", "_build", "bin", "generated", "node_modules", ".svn", ".git", ".hg", ".bzr", ".svn", "website", "_build_logs", "undodir", "obj-x86_64-pc-linux-gnu", "target"}

local function grep_exclude_args()
  local args = {}
  for _, dir in ipairs(exclude_dirs) do
    table.insert(args, "--exclude-dir=" .. vim.fn.shellescape(dir))
  end
  return table.concat(args, " ")
end

-- The dirs of all listed buffers, as maintained in 'path' by init.lua. Dirs
-- nested in another one are dropped: neither grep nor find can skip what they
-- have already seen, so walking both would report every match twice.
local function path_dirs()
  local dirs = vim.iter(vim.opt.path:get())
    :map(function(dir)
      return (dir:gsub("\\(.)", "%1"))
    end)
    :filter(function(dir)
      return dir ~= "" and vim.fn.isdirectory(dir) == 1
    end)
    -- ":p" yields an absolute path with a trailing slash, so a dir is nested in
    -- another exactly when that other one is a prefix of it
    :map(function(dir)
      return vim.fn.fnamemodify(dir, ":p")
    end)
    :unique()
    :totable()
  local roots = vim.iter(dirs)
    :filter(function(dir)
      return not vim.iter(dirs):any(function(other)
        return #other < #dir and dir:sub(1, #other) == other
      end)
    end)
    :map(vim.fn.shellescape)
    :totable()
  if vim.tbl_isempty(roots) then
    roots = { "." }
  end
  return table.concat(roots, " ")
end

local function build_find_cmd()
  local prune = {}
  for _, dir in ipairs(exclude_dirs) do
    table.insert(prune, "-path " .. vim.fn.shellescape("*/" .. dir))
  end
  return "find " .. path_dirs() .. " \\( " .. table.concat(prune, " -o ") .. " \\) -prune -o -type f 2>/dev/null"
end

local function build_grepprg()
  return "LC_ALL=C grep -RIHns " .. grep_exclude_args() .. " $* " .. path_dirs()
end

vim.o.grepprg = build_grepprg()
vim.o.grepformat = "%f:%l:%m"
 
vim.api.nvim_create_autocmd("CmdlineChanged", {
  group = augroup,
  pattern = { ":", "/", "?" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})
 
local files_cache = {}
 
_G._cmdline_find = function(arg, completion)
  if vim.tbl_isempty(files_cache) then
    files_cache = vim.fn.systemlist(build_find_cmd())
  end
  if arg == "" then
    return files_cache
  end
  return vim.fn.matchfuzzy(files_cache, arg)
end
vim.o.findfunc = "v:lua._cmdline_find"
 
vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = augroup,
  pattern = ":",
  callback = function()
    files_cache = {}
    -- 'path' follows the listed buffers, and there is no 'grepfunc' to compute
    -- this lazily, so refresh 'grepprg' from it here
    vim.o.grepprg = build_grepprg()
  end,
})
 
 
local selected_line = ""
 
local function grep_complete(arglead, _, _)
  if #arglead < 3 then
    return {}
  end
  local pat = vim.fn.shellescape(vim.fn.escape(arglead, "\\"))
  local cmd = vim.o.grepprg:gsub("%$%*", function()
    return pat
  end)
  return vim.fn.systemlist(cmd)
end
 
local function visit_file()
  if selected_line == "" then
    return
  end
  local item = vim.fn.getqflist({ lines = { selected_line } }).items[1]
  if not item or not item.bufnr or item.bufnr <= 0 then
    return
  end
  vim.api.nvim_set_current_buf(item.bufnr)
  vim.fn.setpos(".", { 0, item.lnum, item.col, 0 })
  vim.bo[item.bufnr].buflisted = true
end
 
vim.api.nvim_create_user_command("Grep", function()
  visit_file()
end, {
  nargs = "+",
  complete = grep_complete,
})
 
vim.api.nvim_create_autocmd("CmdlineLeavePre", {
  group = augroup,
  pattern = ":",
  callback = function()
    local info = vim.fn.cmdcomplete_info()
    local matches = info.matches or {}
    if vim.tbl_isempty(matches) then
      return
    end
 
    local cmdline = vim.fn.getcmdline()
 
    if cmdline:match("^%s*find?%s") and info.selected == -1 then
      vim.fn.setcmdline("find " .. matches[1])
    end
 
    if cmdline:match("^%s*Grep%s") then
      selected_line = info.selected ~= -1 and matches[info.selected + 1] or matches[1]
      vim.fn.setcmdline(info.cmdline_orig)
    end
  end,
})

local function leave_wildmenu()
  if vim.fn.wildmenumode() == 0 then
    return ""
  end
  -- <C-y> keeps a selected match, <C-e> reverts to what you typed
  return vim.fn.cmdcomplete_info().selected ~= -1 and "<C-y>" or "<C-e>"
end

for _, key in ipairs({ "<Left>", "<Right>", "<Home>", "<End>" }) do
  vim.keymap.set("c", key, function()
    return leave_wildmenu() .. key
  end, { expr = true })
end
