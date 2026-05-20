---@module 'lazy'
---@type LazySpec
return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Apply the last-used colorscheme (persisted across restarts), or fall
      -- back to tokyonight-storm. <leader>tc opens a live-preview picker.
      require('custom.colorscheme').setup 'tokyonight-storm'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
