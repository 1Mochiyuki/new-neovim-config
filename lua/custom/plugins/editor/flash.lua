local M = {}

function M.setup()
  -- Default mappings (s/S/r/R/<c-s>) are enabled by flash's defaults
  require('flash').setup {}
end

return M
