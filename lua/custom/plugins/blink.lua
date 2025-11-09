return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    { 'mikavilpas/blink-ripgrep.nvim' },
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  opts = {
    keymap = {
      preset = 'default',
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
      ['<C-f>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'ripgrep', 'buffer' },
      providers = {
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          opts = {},
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
        Variable = '',
        Property = '󰖷',
        Class = '',
        Interface = '',
        Struct = '',
        Module = '󰅩',
        Unit = '󰑭',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰆕',
        TypeParameter = '',
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
        selection = { preselect = false, auto_insert = false },
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    signature = { enabled = true },
  },
}
