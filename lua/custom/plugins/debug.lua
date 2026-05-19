return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'leoluz/nvim-dap-go',
    },
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Conditional Breakpoint' },
      { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
      { '<leader>dt', function() require('dap-go').debug_test() end, desc = 'Debug: Nearest Go Test' },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

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

      dapui.setup({
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
      })
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
    end,
  },
}
