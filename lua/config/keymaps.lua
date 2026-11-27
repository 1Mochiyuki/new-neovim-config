local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Shows Diagnostics' })
map('n', '<leader>eh', function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = vim.bo.buftype == '' and file ~= '' and vim.fn.fnamemodify(file, ':h') or vim.fn.getcwd()
  vim.ui.input({ prompt = 'Edit relative to ' .. dir .. ': ' }, function(path)
    if not path or path == '' then
      return
    end
    if vim.fn.isabsolutepath(path) == 0 then
      path = vim.fs.joinpath(dir, path)
    end
    vim.cmd.edit({ args = { path } })
  end)
end, { desc = 'Edit file relative to current file' })
map({ 'n', 'i', 'v' }, '<C-s>', '<esc><cmd>w<CR>', { desc = 'Saves current file' })
map('n', '<C-S>S', '<cmd>wa<CR>', { desc = 'Saves ALL files' })
map('n', '<leader>l', function()
  vim.pack.update()
end, { desc = 'Update plugins (vim.pack)' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<C-u>', '<C-u>zz') -- Centers the cursor after jumping half a page
map('n', '<C-d>', '<C-d>zz')

map('v', 'K', ":m '<-2<CR>gv=gv") -- Moving selected text up or down
map('v', 'J', ":m '>+1<CR>gv=gv")

map('n', '<leader>va', 'gg<S-v>G') -- Select All
