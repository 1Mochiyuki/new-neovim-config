require 'config.options'
require 'config.keymaps'

vim.keymap.set('n', '<leader>e', function()
  if MiniFiles.close() ~= nil then
    return
  end
  local file = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.filereadable(file) == 1 and file or nil
  MiniFiles.open(path, false)
end, { desc = 'Toggle file explorer at current file' })

require 'config.plugins'
