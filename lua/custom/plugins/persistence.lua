-- Auto-save a session per working directory; restore on demand.
-- Sessions live in ~/.local/state/nvim/sessions/
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    {
      '<leader>Ss',
      function()
        require('persistence').load()
      end,
      desc = '[S]ession: restore for cwd',
    },
    {
      '<leader>Sl',
      function()
        require('persistence').load { last = true }
      end,
      desc = '[S]ession: restore [L]ast',
    },
    {
      '<leader>Sd',
      function()
        require('persistence').stop()
      end,
      desc = '[S]ession: [D]on\'t save current',
    },
  },
}
