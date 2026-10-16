-- Git setup:
--   gitsigns.nvim  -> per-buffer hunks, blame, stage/reset in-place
--   lazygit.nvim   -> full git TUI in a large floating window
--                     (requires the `lazygit` binary: brew install lazygit)
local function gh(repo) return 'https://github.com/' .. repo end

vim.g.lazygit_floating_window_scaling_factor = 0.95
vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
vim.g.lazygit_use_neovim_remote = 1

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'kdheepak/lazygit.nvim',
}

vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = '[G]it: lazy[G]it' })
vim.keymap.set('n', '<leader>gf', '<cmd>LazyGitCurrentFile<CR>', { desc = '[G]it: lazygit on current [F]ile' })
vim.keymap.set('n', '<leader>gl', '<cmd>LazyGitFilter<CR>', { desc = '[G]it: [L]og (project)' })
vim.keymap.set('n', '<leader>gL', '<cmd>LazyGitFilterCurrentFile<CR>', { desc = '[G]it: [L]og (current file)' })

-- vim: ts=2 sts=2 sw=2 et
