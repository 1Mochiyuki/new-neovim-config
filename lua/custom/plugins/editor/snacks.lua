return {
  {
    'folke/snacks.nvim',
    dependencies = {
      {
        'folke/edgy.nvim',
        ---@module 'edgy'
        ---@param opts Edgy.Config
        opts = function(_, opts)
          for _, pos in ipairs { 'top', 'bottom', 'left', 'right' } do
            opts[pos] = opts[pos] or {}
            table.insert(opts[pos], {
              ft = 'snacks_terminal',
              size = { height = 0.4 },
              title = '%{b:snacks_terminal.id}: %{b:term_title}',
              filter = function(_buf, win)
                return vim.w[win].snacks_win
                  and vim.w[win].snacks_win.position == pos
                  and vim.w[win].snacks_win.relative == 'editor'
                  and not vim.w[win].trouble_preview
              end,
            })
          end
        end,
      },
    },
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = {
        enabled = true,
        indent = { enabled = false },
        scope = { enabled = true },
        animate = { enabled = false },
      },
      input = {
        enabled = true,
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      terminal = {
        win = {
          position = 'float',
        },
      },
      lazygit = { enable = true },
      picker = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
      },
    },

    keys = {
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>vnt',
        function()
          local termOptions = {
            win = {
              position = 'right',
            },
          }
          Snacks.terminal.open(nil, termOptions)
        end,
        desc = 'Open Terminal in Vertical New Tab',
      },
      {
        '<leader>nt',
        function()
          local termOptions = {
            win = {
              position = 'bottom',
              height = 0.35,
            },
          }
          Snacks.terminal.open(nil, termOptions)
        end,
        desc = 'Open Terminal in New Tab',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<c-_>',
        function()
          Snacks.terminal()
        end,
        desc = 'which_key_ignore',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end

          -- Override print to use snacks for `:=` command
          if vim.fn.has 'nvim-0.11' == 1 then
            vim._print = function(_, ...)
              dd(...)
            end
          else
            vim.print = _G.dd
          end

          -- Create some toggle mappings

          Snacks.toggle.indent():map '<leader>ug'
          Snacks.toggle.dim():map '<leader>uD'
        end,
      })
    end,
  },
}
