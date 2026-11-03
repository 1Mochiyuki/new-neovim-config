local M = {}

function M.setup()
  require('blink.cmp').setup {
    keymap = {
      ['<CR>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'fallback',
      },

      ['<S-space>'] = false,
      ['<C-e>'] = { 'hide', 'fallback' },

      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          end
          -- accept the selected completion if the menu is visible
          if cmp.select_and_accept() then
            return true
          end
          -- jump out of a pair if a closer is directly under the cursor
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local next_char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
          local closers = ')]}>"\'`'
          if closers:find(next_char, 1, true) then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true), 'n', false)
            return true
          end
          return false
        end,
        'fallback',
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'ripgrep', 'buffer' },
      providers = {
        lsp = {
          score_offset = 1000,
        },
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          opts = {
            prefix_min_len = 3,
          },
        },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'normal',
      kind_icons = {
        Ripgrep = '[RG]',
        Text = '󰉿',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '',
        Property = '󰖷',
        Class = '',
        Interface = '',
        Struct = '',
        Module = '󰅩',
        Unit = '󰑭',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰆕',
        TypeParameter = '',
      },
    },

    completion = {
      menu = {
        border = 'rounded',
        scrollbar = false,
        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 2 }, { 'source_name' } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
      documentation = { auto_show = false, auto_show_delay_ms = 750 },
      keyword = {
        range = 'full',
      },
      trigger = {
        show_on_accept_on_trigger_character = false,
        show_on_insert_on_trigger_character = true,
      },
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },

    snippets = { preset = 'default' },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    signature = { enabled = true },
  }
end

return M
