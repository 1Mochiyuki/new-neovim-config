local M = {}

function M.setup()
  require('mason').setup {
    registries = {
      'github:mason-org/mason-registry',
      'github:Crashdummyy/mason-registry',
    },
  }
  require('mason-tool-installer').setup {
    ensure_installed = M.ensure_installed,
  }

  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  })

  local servers = {
    'gopls',
    'lua_ls',
    'tsc',
    'svelte',
    'tailwindcss',
    'marksman',
    'html',
    'jsonls',
    'roslyn',
    'oxlint',
    'jdtls',
    'rust_analyzer',
    'clangd',
    'kotlin_lsp',
  }
  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('grr', function()
        Snacks.picker.lsp_references()
      end, '[G]oto [R]eferences')
      map('gri', function()
        Snacks.picker.lsp_implementations()
      end, '[G]oto [I]mplementation')
      map('gd', function()
        Snacks.picker.lsp_definitions()
      end, '[G]oto [D]efinition')
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gO', function()
        Snacks.picker.lsp_document_symbols()
      end, 'Open Document Symbols')
      map('gW', function()
        Snacks.picker.lsp_workspace_symbols()
      end, 'Open Workspace Symbols')
      map('grt', function()
        Snacks.picker.lsp_type_definitions()
      end, '[G]oto [T]ype Definition')

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = false,
    virtual_text = false,

    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
  }
end

-- Mason package names, which can differ from LSP configuration names.
M.ensure_installed = {
  'ast-grep',
  'gopls',
  'lua-language-server',
  'tsc',
  'svelte-language-server',
  'tailwindcss-language-server',
  'marksman',
  'html-lsp',
  'json-lsp',
  'oxlint',
  'jdtls',
  'rust-analyzer',
  'clangd',
  'kotlin-lsp',
  'roslyn', -- Crashdummyy registry package used by roslyn.nvim
  'csharpier',
  'stylua',
  'prettierd',
  'prettier',
}

return M
