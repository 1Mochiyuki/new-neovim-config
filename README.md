# My neovim config :)

Based off Kickstart.nvim

Requires Neovim 0.12+ 

## Plugins:

- [vim.pack](https://neovim.io/doc/user/pack.html) 
- plenary.nvim
- mason.nvim + nvim-lspconfig
- blink.cmp (pinned to 1.x):
  - blink-ripgrep.nvim
  - friendly-snippets
- nvim-treesitter:
  - nvim-ts-autotag
- snacks.nvim:
  - picker (fuzzy finder, replaces Telescope)
  - notifier
  - quickfile
  - bigfile
  - terminal
  - lazygit
  - indent
  - input
- mini.nvim:
  - mini.pairs (autopairs)
  - mini.surround
  - mini.operators
  - mini.ai
  - mini.splitjoin
  - mini.files
  - mini.icons
- gitsigns.nvim
- guess-indent.nvim
- which-key.nvim
- lualine.nvim:
  - lualine-macro-recording.nvim
- colorful-menu.nvim
- flash.nvim
- lazydev.nvim
- conform.nvim
- flutter-tools.nvim
- kotlin.nvim
- roslyn.nvim (C# / F# LSP)
- markdown-preview.nvim

## Language servers (Mason / LSP):

- Kotlin (kotlin.nvim)
- C# (roslyn.nvim)
- Flutter / Dart (flutter-tools.nvim)
- Lua 
- Go (gopls)

## Theme:
- vesper.nvim

Use `<leader>uC` to preview and select a colorscheme, or run
`:colorscheme alabaster-sharp`, `:colorscheme koda-light`, or `:colorscheme vesper`.
To choose the startup theme, change the colorscheme in `lua/custom/plugins/ui/theme.lua`.
Per-theme highlight overrides live in `lua/custom/plugins/ui/themes/alabaster-sharp.lua`
and `lua/custom/plugins/ui/themes/koda-light.lua`; edit them and reselect the theme.
