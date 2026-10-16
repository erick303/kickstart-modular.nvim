-- Alternative colorschemes. Switch with <leader>tc or :colorscheme <name>.
-- Top picks: tokyonight-storm, catppuccin-mocha, kanagawa-wave,
-- gruvbox-material, rose-pine-moon.
local function gh(repo) return 'https://github.com/' .. repo end

vim.g.gruvbox_material_background = 'medium' -- soft | medium | hard
vim.g.gruvbox_material_better_performance = 1

vim.pack.add {
  gh 'rebelot/kanagawa.nvim',
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },
  gh 'sainnhe/gruvbox-material',
  { src = gh 'rose-pine/neovim', name = 'rose-pine' },
}

require('catppuccin').setup { flavour = 'mocha' }
require('rose-pine').setup { variant = 'moon' }

-- Apply the last-used colorscheme (persisted across restarts), or fall
-- back to tokyonight-storm. This runs here, not in tokyonight.lua, so a
-- saved choice from the themes above is installed before it is applied.
require('custom.colorscheme').setup 'tokyonight-storm'

-- vim: ts=2 sts=2 sw=2 et
