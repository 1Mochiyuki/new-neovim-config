local M = {}

function M.setup()
  local previous_guicursor
  -- Apply the newsprint palette throughout Koda Light, including plugin UI
  -- groups and colors derived from its background. Other variants stay intact.
  require('koda').setup {
    colors = {
      light = require 'custom.plugins.ui.themes.koda-light-palette',
    },
  }
  local overrides = {
    ['alabaster-sharp'] = 'custom.plugins.ui.themes.alabaster-sharp',
    ['alabaster-sharp-bg'] = 'custom.plugins.ui.themes.alabaster-sharp',
    ['koda-light'] = 'custom.plugins.ui.themes.koda-light',
  }

  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('custom-theme-overrides', { clear = true }),
    callback = function(event)
      local restoring_cursor = previous_guicursor ~= nil
      if previous_guicursor then
        vim.o.guicursor = previous_guicursor
        previous_guicursor = nil
      end
      -- Explicitly apply Vesper's own cursor after Koda so terminals don't retain
      -- Koda's cursor color when the original setting has no highlight group.
      if event.match == 'koda-light' or (event.match == 'vesper' and restoring_cursor) then
        previous_guicursor = vim.o.guicursor
        vim.opt.guicursor:append 'a:Cursor'
      end
      local module = overrides[event.match]
      if not module then
        return
      end
      -- Reload so editing an override file and reselecting the theme applies it.
      package.loaded[module] = nil
      for group, highlight in pairs(require(module)) do
        vim.api.nvim_set_hl(0, group, highlight)
      end
    end,
  })

  vim.keymap.set('n', '<leader>uC', function()
    Snacks.picker.colorschemes()
  end, { desc = 'Choose colorscheme' })

  -- Change this to 'alabaster-sharp' or 'koda-light' to make it the default.
  vim.cmd.colorscheme 'koda-light'
end

return M
