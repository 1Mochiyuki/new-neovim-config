-- Overrides applied after :colorscheme koda-light.
-- Comment out any entry and reselect the colorscheme to restore Koda's default.
return {
  -- Classic newsprint background; keep Koda's original foreground.
  Normal = { fg = '#101010', bg = '#e3dfd2' },
  FloatBorder = { fg = '#101010', bg = '#e3dfd2' },
  Pmenu = { fg = '#101010', bg = '#e3dfd2' },
  PmenuSel = { fg = '#101010', bg = '#c5bfae', bold = true },

  -- Near-black types and bold keywords keep syntax readable without new colors.
  Type = { fg = '#101010' },
  Keyword = { fg = '#101010', bold = true },
  Statement = { fg = '#101010', bold = true },
  Include = { fg = '#101010', bold = true },
  Define = { fg = '#101010', bold = true },
  StorageClass = { fg = '#101010', bold = true },
  Structure = { fg = '#101010', bold = true },
  Typedef = { fg = '#101010', bold = true },
  ['@lsp.type.type'] = { fg = '#101010' },
  ['@lsp.type.class'] = { fg = '#101010' },
  ['@lsp.type.interface'] = { fg = '#101010' },
  ['@lsp.type.enum'] = { fg = '#101010' },
  -- Distinguish structs from classes and interfaces without adding color.
  ['@lsp.type.struct'] = { fg = '#101010', bold = true },

  -- Warm newsprint shades for the cursor and current line.
  Cursor = { fg = '#faf8f1', bg = '#92918b' },
  CursorLine = { bg = '#d2cebf' },
  -- Match the empty statusline and tabline areas to the newsprint palette.
  StatusLine = { fg = '#101010', bg = '#d2cebf' },
  StatusLineNC = { fg = '#555047', bg = '#d2cebf' },
  TabLineFill = { fg = '#555047', bg = '#d2cebf' },

  -- Distinct warm shades for visual selections, searches, and LSP references.
  Visual = { bg = '#bcb4a2' },
  Search = { fg = '#101010', bg = '#c9bfa8' },
  CurSearch = { fg = '#101010', bg = '#ad9d7e' },
  IncSearch = { link = 'CurSearch' },
  LspReferenceText = { bg = '#d0c7b5' },
  LspReferenceRead = { link = 'LspReferenceText' },
  LspReferenceWrite = { bg = '#c4b9a5' },

  -- Additional examples:
  -- Comment = { fg = '#665544', italic = true },
  -- ['@string'] = { fg = '#185400' },
}
