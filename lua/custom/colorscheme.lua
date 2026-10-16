-- Persist the active colorscheme across nvim restarts.
-- Stored at $XDG_STATE_HOME/nvim/colorscheme.txt.

local M = {}

local state_file = vim.fn.stdpath 'state' .. '/colorscheme.txt'

local function read()
  local f = io.open(state_file, 'r')
  if not f then return nil end
  local name = f:read '*l'
  f:close()
  if not name or name == '' then return nil end
  return name
end

local function write(name)
  local f = io.open(state_file, 'w')
  if not f then return end
  f:write(name)
  f:close()
end

---@param default string colorscheme to use when no saved choice exists
function M.setup(default)
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('PersistColorscheme', { clear = true }),
    callback = function(args)
      if args.match and args.match ~= '' then write(args.match) end
    end,
  })

  local target = read() or default
  local ok = pcall(vim.cmd.colorscheme, target)
  if not ok and target ~= default then
    -- Saved colorscheme no longer installed; fall back to the default.
    pcall(vim.cmd.colorscheme, default)
  end
end

return M
