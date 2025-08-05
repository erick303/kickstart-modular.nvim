-- https://github.com/iamcco/markdown-preview.nvim
return {
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
