local config = {
  options = {
    theme = function()
      if vim.g.colors_name == 'koda-light' then
        return require 'custom.plugins.ui.themes.koda-light-lualine'
      end
      return 'auto'
    end,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {},
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        'mode',
        separator = { left = '' },
        right_padding = 2,
        left_padding = 2,
      },
    },
    lualine_b = {
      'branch',
      'diff',
      {
        'filename',
        path = 4,
      },
    },

    lualine_c = {
      'macro_recording',
    },
    lualine_x = { { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_y = {
      {
        function()
          return '@staticdots ૮₍ • ˕ - ₎ა♡'
        end,
      },
    },
    lualine_z = {
      {
        separator = { right = '' },
        function()
          local clients = vim.lsp.get_clients()
          local msg = 'LSP: '
          if #clients <= 0 then
            return msg .. 'None'
          end

          return msg .. clients[1].name
        end,
        right_padding = 2,
      },
    },
  },
  extensions = {},
}

local M = {}

function M.setup()
  require('lualine').setup(config)
end

return M
