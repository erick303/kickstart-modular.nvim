-- Git setup:
--   gitsigns.nvim  -> per-buffer hunks, blame, stage/reset in-place
--   lazygit.nvim   -> full git TUI in a large floating window
--                     (requires the `lazygit` binary: brew install lazygit)
return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = '[G]it: lazy[G]it' },
      { '<leader>gf', '<cmd>LazyGitCurrentFile<CR>', desc = '[G]it: lazygit on current [F]ile' },
      { '<leader>gl', '<cmd>LazyGitFilter<CR>', desc = '[G]it: [L]og (project)' },
      { '<leader>gL', '<cmd>LazyGitFilterCurrentFile<CR>', desc = '[G]it: [L]og (current file)' },
    },
    init = function()
      vim.g.lazygit_floating_window_scaling_factor = 0.95
      vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
      vim.g.lazygit_use_neovim_remote = 1
    end,
  },
}
