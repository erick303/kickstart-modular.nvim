-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    filtered_items = {
      hide_gitignored = false,
    },
    window = {
      mappings = {
        ['\\'] = 'close_window',
        ['gx'] = 'system_open',
        ['Y'] = 'copy_path_absolute',
        ['gy'] = 'copy_path_relative',
        ['gY'] = 'copy_name',
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        vim.fn.jobstart({ 'open', node.path }, { detach = true })
      end,
      copy_path_absolute = function(state)
        local path = state.tree:get_node():get_id()
        vim.fn.setreg('+', path)
        vim.notify('Copied: ' .. path)
      end,
      copy_path_relative = function(state)
        local path = vim.fn.fnamemodify(state.tree:get_node():get_id(), ':.')
        vim.fn.setreg('+', path)
        vim.notify('Copied: ' .. path)
      end,
      copy_name = function(state)
        local name = state.tree:get_node().name
        vim.fn.setreg('+', name)
        vim.notify('Copied: ' .. name)
      end,
    },
  },
}
