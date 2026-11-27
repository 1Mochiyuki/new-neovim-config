local M = {}

-- vim.g.mkdp_filetypes is set in config/plugins.lua before plugins load
function M.setup()
  vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'Toggle Markdown preview' })
end

return M
