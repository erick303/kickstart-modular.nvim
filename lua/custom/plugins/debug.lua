local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'mfussenegger/nvim-dap',
  gh 'rcarriga/nvim-dap-ui',
  gh 'nvim-neotest/nvim-nio',
  gh 'mason-org/mason.nvim',
  gh 'jay-babu/mason-nvim-dap.nvim',
  gh 'leoluz/nvim-dap-go',
  gh 'Joakker/lua-json5',
}

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set(
  'n',
  '<leader>B',
  function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
  { desc = 'Debug: Conditional Breakpoint' }
)
vim.keymap.set('n', '<F7>', function() require('dapui').toggle() end, { desc = 'Debug: Toggle UI' })
vim.keymap.set('n', '<leader>dt', function() require('dap-go').debug_test() end, { desc = 'Debug: Nearest Go Test' })
vim.keymap.set('n', '<leader>p', function()
  local dap = require 'dap'
  local items = {}

  local ok, configs = pcall(require('dap.ext.vscode').getconfigs, vim.fn.getcwd() .. '/.vscode/launch.json')
  if ok then
    for _, c in ipairs(configs) do
      table.insert(items, { kind = 'debug', label = '  ' .. c.name, config = c })
    end
  end

  if vim.fn.filereadable 'Taskfile.yml' == 1 and vim.fn.executable 'task' == 1 then
    local out = vim.fn.systemlist { 'task', '--list-all', '--json' }
    local ok2, parsed = pcall(vim.json.decode, table.concat(out, '\n'))
    if ok2 and parsed and parsed.tasks then
      for _, t in ipairs(parsed.tasks) do
        table.insert(items, { kind = 'task', label = '  ' .. t.name, name = t.name, desc = t.desc })
      end
    end
  end

  vim.ui.select(items, {
    prompt = 'Run:',
    format_item = function(i) return i.label .. (i.desc and i.desc ~= '' and '  — ' .. i.desc or '') end,
  }, function(i)
    if not i then return end
    if i.kind == 'debug' then
      dap.run(i.config)
    else
      vim.cmd('split | terminal task ' .. i.name)
    end
  end)
end, { desc = 'Run: debug config or task' })

local dap = require 'dap'
local dapui = require 'dapui'

-- pcall: the native module is missing until install.sh has run once.
local json5_ok, json5 = pcall(require, 'json5')
if json5_ok then require('dap.ext.vscode').json_decode = json5.parse end

require('mason-nvim-dap').setup {
  automatic_installation = true,
  ensure_installed = { 'delve' },
}

vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_signs = {
  DapBreakpoint = { '●', 'DapBreak' },
  DapBreakpointCondition = { '◆', 'DapBreak' },
  DapBreakpointRejected = { '●', 'DapBreak' },
  DapLogPoint = { '◆', 'DapBreak' },
  DapStopped = { '▶', 'DapStop' },
}
for name, sign in pairs(breakpoint_signs) do
  vim.fn.sign_define(name, { text = sign[1], texthl = sign[2], numhl = sign[2] })
end

dapui.setup {
  layouts = {
    {
      elements = {
        { id = 'repl', size = 1.0 },
      },
      size = 10,
      position = 'bottom',
    },
    {
      elements = {
        { id = 'scopes', size = 0.45 },
        { id = 'watches', size = 0.30 },
        { id = 'breakpoints', size = 0.13 },
        { id = 'stacks', size = 0.12 },
      },
      size = 40,
      position = 'right',
    },
  },
}
vim.api.nvim_create_autocmd({ 'FileType', 'BufWinEnter', 'WinEnter' }, {
  callback = function(args)
    if vim.bo[args.buf].filetype == 'dap-repl' then
      for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
        vim.wo[win].wrap = true
        vim.wo[win].linebreak = true
      end
    end
  end,
})

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

require('dap-go').setup()

-- vim: ts=2 sts=2 sw=2 et
