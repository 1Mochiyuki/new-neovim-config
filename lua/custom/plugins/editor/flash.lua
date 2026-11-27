local M = {}

function M.setup()
  require('flash').setup {}
  vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jj', function()
    require('flash').jump()
  end, { desc = 'Flash jump' })
  vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jt', function()
    require('flash').treesitter()
  end, { desc = 'Flash Treesitter selection' })
  vim.keymap.set('o', '<leader>jr', function()
    require('flash').remote()
  end, { desc = 'Flash remote operation' })
  vim.keymap.set({ 'x', 'o' }, '<leader>js', function()
    require('flash').treesitter_search()
  end, { desc = 'Flash Treesitter search' })
end

return M
