local M = {}

function M.setup()
  require('mini.splitjoin').setup {}
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
  require('mini.icons').setup()
end

return M
