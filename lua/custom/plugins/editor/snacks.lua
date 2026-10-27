local M = {}

function M.setup()
  require('edgy').setup {
    top = {
      {
        ft = 'snacks_terminal',
        size = { height = 0.4 },
        title = '%{b:snacks_terminal.id}: %{b:term_title}',
        filter = function(_buf, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == 'top'
            and vim.w[win].snacks_win.relative == 'editor'
            and not vim.w[win].trouble_preview
        end,
      },
    },
    bottom = {
      {
        ft = 'snacks_terminal',
        size = { height = 0.4 },
        title = '%{b:snacks_terminal.id}: %{b:term_title}',
        filter = function(_buf, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == 'bottom'
            and vim.w[win].snacks_win.relative == 'editor'
            and not vim.w[win].trouble_preview
        end,
      },
    },
    left = {
      {
        ft = 'snacks_terminal',
        size = { height = 0.4 },
        title = '%{b:snacks_terminal.id}: %{b:term_title}',
        filter = function(_buf, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == 'left'
            and vim.w[win].snacks_win.relative == 'editor'
            and not vim.w[win].trouble_preview
        end,
      },
    },
    right = {
      {
        ft = 'snacks_terminal',
        size = { height = 0.4 },
        title = '%{b:snacks_terminal.id}: %{b:term_title}',
        filter = function(_buf, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == 'right'
            and vim.w[win].snacks_win.relative == 'editor'
            and not vim.w[win].trouble_preview
        end,
      },
    },
  }

  require('snacks').setup {
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
  }

  local map = function(lhs, fn, desc)
    vim.keymap.set('n', lhs, fn, { desc = desc })
  end

  map('<leader>gg', function()
    Snacks.lazygit()
  end, 'Lazygit')
  map('<leader>vnt', function()
    Snacks.terminal.open(nil, { win = { position = 'right' } })
  end, 'Open Terminal in Vertical New Tab')
  map('<leader>nt', function()
    Snacks.terminal.open(nil, { win = { position = 'bottom', height = 0.35 } })
  end, 'Open Terminal in New Tab')
  map('<c-/>', function()
    Snacks.terminal()
  end, 'Toggle Terminal')
  map('<c-_>', function()
    Snacks.terminal()
  end, 'which_key_ignore')

  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end
      _G.bt = function()
        Snacks.debug.backtrace()
      end

      if vim.fn.has 'nvim-0.11' == 1 then
        vim._print = function(_, ...)
          dd(...)
        end
      else
        vim.print = _G.dd
      end

      Snacks.toggle.indent():map '<leader>ug'
      Snacks.toggle.dim():map '<leader>uD'
    end,
  })
end

return M
