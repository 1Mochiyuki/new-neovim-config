require 'config.options'
require 'config.keymaps'

vim.keymap.set('n', '<leader>e', ':lua MiniFiles.open()<CR>')

require 'config.plugins'
