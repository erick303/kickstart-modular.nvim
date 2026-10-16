-- https://github.com/coder/claudecode.nvim
local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'folke/snacks.nvim',
  gh 'coder/claudecode.nvim',
}

require('claudecode').setup {
  terminal_cmd = 'claude',
  terminal = {
    split_width_percentage = 0.35,
  },
}

require('which-key').add { { '<leader>a', group = 'AI/Claude Code' } }

local map = function(lhs, rhs, desc, mode) vim.keymap.set(mode or 'n', lhs, rhs, { desc = desc }) end

map('<leader>ac', '<cmd>ClaudeCode<cr>', 'Toggle Claude')
map('<leader>af', '<cmd>ClaudeCodeFocus<cr>', 'Focus Claude')
map('<leader>ar', '<cmd>ClaudeCode --resume<cr>', 'Resume Claude')
map('<leader>aC', '<cmd>ClaudeCode --continue<cr>', 'Continue Claude')
map('<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', 'Select Claude model')
map('<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', 'Add current buffer')
map('<leader>as', '<cmd>ClaudeCodeSend<cr>', 'Send to Claude', 'v')
-- Diff management
map('<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', 'Accept diff')
map('<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', 'Deny diff')

-- In file explorers, <leader>as adds the file under the cursor instead.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('custom-claudecode-tree', { clear = true }),
  pattern = { 'NvimTree', 'neo-tree', 'oil', 'minifiles' },
  callback = function(ev) vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { buffer = ev.buf, desc = 'Add file' }) end,
})

-- vim: ts=2 sts=2 sw=2 et
