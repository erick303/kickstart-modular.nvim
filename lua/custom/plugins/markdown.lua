-- https://github.com/iamcco/markdown-preview.nvim
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = { 'n', 'c', 't' },
      anti_conceal = {
        enabled = true,
        above = 1,
        below = 1,
      },
      -- Structural choice (theme-agnostic): no full-width tinted bands behind
      -- headings. Heading text colors still come from whichever theme is active.
      heading = {
        backgrounds = { 'Normal', 'Normal', 'Normal', 'Normal', 'Normal', 'Normal' },
      },
    },
    config = function(_, opts)
      require('render-markdown').setup(opts)

      -- Universal tweak: strip the tinted background box behind inline `code`
      -- spans. Themes differ in which highlight group owns the box, so we
      -- target all three common ones. Heading and dash colors are left alone.
      local function strip_inline_bg()
        for _, group in ipairs { '@markup.raw.markdown_inline', '@markup.raw', 'RenderMarkdownCodeInline' } do
          local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
          if hl.bg ~= nil or hl.ctermbg ~= nil then
            vim.api.nvim_set_hl(0, group, {
              fg = hl.fg,
              ctermfg = hl.ctermfg,
              bold = hl.bold,
              italic = hl.italic,
            })
          end
        end
        -- render-markdown caches a combined hl group; force a rebuild.
        pcall(function()
          require('render-markdown.core.colors').reload()
        end)
      end

      strip_inline_bg()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('MarkdownInlineCodeBg', { clear = true }),
        callback = strip_inline_bg,
      })
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    keys = {
      { '<C-p>', '<Plug>MarkdownPreviewToggle', desc = 'Toggle markdown preview' },
      -- { '<C-s>', '<Plug>MarkdownPreview', desc = 'Start markdown preview' },
      -- { '<M-s>', '<Plug>MarkdownPreviewStop', desc = 'Stop markdown preview' },
    },
  },
}
