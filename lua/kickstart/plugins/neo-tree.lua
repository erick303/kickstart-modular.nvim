-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
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
  },
}
