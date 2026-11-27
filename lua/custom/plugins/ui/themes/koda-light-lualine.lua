-- Koda Light's statusline and tabline colors, kept separate for easy tuning.
local text = '#101010'
local background = '#d2cebf'
local section = '#c5bfae'

local function mode(accent)
  return {
    a = { fg = text, bg = accent, gui = 'bold' },
    b = { fg = text, bg = section },
    c = { fg = text, bg = background },
  }
end

return {
  normal = mode '#bcb4a2',
  insert = mode '#b9c1a6',
  visual = mode '#c9b59c',
  replace = mode '#c9a99c',
  command = mode '#c9bfa8',
  inactive = mode '#c5bfae',
}
