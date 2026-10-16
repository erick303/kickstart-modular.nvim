-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- https://github.com/iamcco/markdown-preview.nvim
-- Both depend on nvim-treesitter and mini.nvim, which kickstart loads first.
local function gh(repo) return 'https://github.com/' .. repo end

vim.g.mkdp_filetypes = { 'markdown' }

vim.pack.add {
  gh 'MeanderingProgrammer/render-markdown.nvim',
  gh 'iamcco/markdown-preview.nvim',
}

---@module 'render-markdown'
---@type render.md.UserConfig
require('render-markdown').setup {
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
}

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
  pcall(function() require('render-markdown.core.colors').reload() end)
end

strip_inline_bg()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('MarkdownInlineCodeBg', { clear = true }),
  callback = strip_inline_bg,
})

vim.keymap.set('n', '<C-p>', '<Plug>MarkdownPreviewToggle', { desc = 'Toggle markdown preview' })

-- vim: ts=2 sts=2 sw=2 et
