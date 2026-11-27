local M = {}

function M.setup()
  require('gradle').setup {}
  vim.keymap.set('n', '<leader>agg', '<cmd>Gradle<cr>', { desc = 'Gradle projects' })
  vim.keymap.set('n', '<leader>agf', '<cmd>GradleFavorites<cr>', { desc = 'Gradle favorites' })
  vim.keymap.set('n', '<leader>age', '<cmd>GradleExec<cr>', { desc = 'Execute Gradle command' })
  vim.keymap.set('n', '<leader>agi', '<cmd>GradleInit<cr>', { desc = 'Initialize Gradle project' })
end

return M
