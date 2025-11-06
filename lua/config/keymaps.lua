local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map({ 'n', 'i' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Saves current file' })
map('n', '<C-S>', '<cmd>wa<cr><esc>', { desc = 'Saves ALL file' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- vim.keymap.set('n', '<C-/', '<cmd>lua Snacks.terminal()<CR>')
--
-- vim.keymap.set('v', '<leader>rn', ':IncRename ')
-- vim.keymap.set('n', '<leader>rn', function()
--   return ':IncRename ' .. vim.fn.expand '<cword>'
-- end, {})
