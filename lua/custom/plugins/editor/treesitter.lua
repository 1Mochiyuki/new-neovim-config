local M = {}

function M.setup()
  local treesitter = require 'nvim-treesitter'

  local ensure_installed = {
    'javascript',
    'go',
    'tsx',
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
  }
  treesitter.install(ensure_installed)

  vim.api.nvim_create_autocmd('FileType', {
    desc = 'Treesitter: start highlighting, install missing parsers',
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match) or args.match
      if not pcall(vim.treesitter.language.add, lang) then
        -- Parser missing: install it in the background, available next open
        pcall(treesitter.install, { lang })
        return
      end
      pcall(vim.treesitter.start, args.buf, lang)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  require('nvim-ts-autotag').setup()
end

return M
