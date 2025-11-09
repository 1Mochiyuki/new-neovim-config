return {
  {
    'nvim-mini/mini.nvim',
    version = '*',
    config = function()
      require('mini.splitjoin').setup {}
      require('mini.surround').setup()
      require('mini.ai').setup()
      require('mini.operators').setup {
        mappings = {
          splitjoin = 'gS',
        },
      }

      require('mini.files').setup {
        mappings = {
          go_in = '<CR>',
        },
      }

      require('mini.surround').setup {
        mappings = {
          add = '<leader>sa',
          delete = '<leader>sd',
          find = '<leader>sf',
          find_left = '<leader>sF',
          highlight = '<leader>sh',
          update_n_lines = '<leader>sn',
        },
      }
    end,
  },
  {
    'nvim-mini/mini.icons',
    style = 'glyph',
    config = function()
      require('mini.icons').setup()
    end,
  },
}
