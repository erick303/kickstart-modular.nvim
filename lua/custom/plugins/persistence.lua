-- Auto-save a session per working directory; restore on demand.
-- Sessions live in ~/.local/state/nvim/sessions/
vim.pack.add { 'https://github.com/folke/persistence.nvim' }
require('persistence').setup {}

vim.keymap.set('n', '<leader>Ss', function() require('persistence').load() end, { desc = '[S]ession: restore for cwd' })
vim.keymap.set('n', '<leader>Sl', function() require('persistence').load { last = true } end, { desc = '[S]ession: restore [L]ast' })
vim.keymap.set('n', '<leader>Sd', function() require('persistence').stop() end, { desc = "[S]ession: [D]on't save current" })

-- vim: ts=2 sts=2 sw=2 et
