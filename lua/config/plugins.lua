-- Plugin management via built-in vim.pack (Neovim 0.12+)
-- Plugins install to %LOCALAPPDATA%\nvim-data\site\pack\core\opt
-- nvim-pack-lock.json pins revisions and must be committed.

-- Build hooks must be registered before the first vim.pack call so they
-- also fire for installs performed from the lockfile.
vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'vim.pack build hooks',
  callback = function(ev)
    local data = ev.data
    local name = data.spec.name
    if name == 'markdown-preview.nvim' and (data.kind == 'install' or data.kind == 'update') then
      vim.system({ 'bun', 'install' }, { cwd = vim.fs.joinpath(data.path, 'app') }):wait()
    end
  end,
})

vim.g.mkdp_filetypes = { 'markdown' }

vim.pack.add({
  -- dependencies first
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },

  -- ui
  { src = 'https://github.com/datsfilipe/vesper.nvim' },
  { src = 'https://github.com/nuvic/alabaster-sharp.nvim' },
  { src = 'https://github.com/oskarnurm/koda.nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/yavorski/lualine-macro-recording.nvim' },
  { src = 'https://github.com/xzbdmw/colorful-menu.nvim' },

  -- editor
  { src = 'https://github.com/folke/flash.nvim' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/nvim-flutter/flutter-tools.nvim' },
  { src = 'https://github.com/iamcco/markdown-preview.nvim' },
  { src = 'https://github.com/oclay1st/gradle.nvim' },

  -- lsp / completion
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/mikavilpas/blink-ripgrep.nvim' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  -- blink.cmp 2.0 is coming; stay on 1.x until it is released and reviewed
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
  { src = 'https://github.com/AlexandrosAlexiou/kotlin.nvim' },
  { src = 'https://github.com/seblyng/roslyn.nvim' },
}, { confirm = false })

-- [[ Setups ]]
-- Theme first so plugin windows are colored from the start
require('custom.plugins.ui.theme').setup()
require('custom.plugins.ui.which-key').setup()
require('custom.plugins.ui.gitsigns').setup()
require('custom.plugins.ui.picker').setup()
require('custom.plugins.ui.lualine').setup()
require('custom.plugins.ui.colorful-menu').setup()

require('custom.plugins.editor.mini').setup()
require('custom.plugins.editor.snacks').setup()
require('custom.plugins.editor.flash').setup()
require('custom.plugins.editor.conform').setup()
require('custom.plugins.editor.autopairs').setup()
require('custom.plugins.editor.lazydev').setup()
require('custom.plugins.editor.markdown-preview').setup()
require('custom.plugins.editor.treesitter').setup()
require('custom.plugins.editor.gradle').setup()
require('custom.plugins.editor.flutter').setup()

require('custom.plugins.lsp.lsp').setup()
require('custom.plugins.lsp.blink').setup()
require('custom.plugins.lsp.kotlin').setup()
require('custom.plugins.lsp.csharp').setup()

require('guess-indent').setup {}
