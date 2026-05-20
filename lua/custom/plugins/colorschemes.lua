-- Alternative colorschemes. Switch with <leader>tc or :colorscheme <name>.
-- Top picks: tokyonight-storm, catppuccin-mocha, kanagawa-wave,
-- gruvbox-material, rose-pine-moon.
return {
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    opts = { flavour = 'mocha' },
  },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
    init = function()
      vim.g.gruvbox_material_background = 'medium' -- soft | medium | hard
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    opts = { variant = 'moon' },
  },
}
