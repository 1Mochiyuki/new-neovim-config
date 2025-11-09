return {{
  'williamboman/mason.nvim',
  opts = {},
}, {
  'williamboman/mason-lspconfig.nvim',
  dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    ensure_installed = { 'lua_ls', 'gopls', 'vtsls', 'html', 'tailwindcss', 'svelte' },
    config = function()
      local function lsp_setup_keymaps(bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation and Information
        map('n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to Declaration')
        map('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to Definition')
        map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover Documentation')
        map('n', 'gi', vim.lsp.buf.implementation, 'LSP: Go to Implementation')
        map('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'LSP: Workspace Symbol')
        map('n', 'gr', vim.lsp.buf.references, 'LSP: Find References')
        map('n', 'gT', vim.lsp.buf.type_definition, 'LSP: Type Definition')

        -- Code Actions and Refactoring
        map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: Code Action')
        map('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: Rename')
        map('n', '<leader>fm', vim.lsp.buf.format, 'LSP: Format Buffer')

        -- Diagnostics (Errors/Warnings)
        map('n', '[d', vim.diagnostic.jump { count = -1, float = true }, 'Go to Previous Diagnostic')
        map('n', ']d', vim.diagnostic.jump { count = 1, float = true }, 'Go to Next Diagnostic')
        map('n', '<leader>dl', vim.diagnostic.set_loclist, 'Set Diagnostic Loclist')
      end
      vim.lsp.config('*', {
        -- This is merged into every server's config
        -- * applies to all servers
        on_attach = lsp_setup_keymaps,
        flags = {
          debounce_text_changes = 150,
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
    end,
    -- handlers = {
    --   function(server_name)
    --     require('lspconfig')[server_name].setup {}
    --   end,
    -- },
  },
}}
