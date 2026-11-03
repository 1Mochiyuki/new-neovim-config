local M = {}

function M.setup()
  require('roslyn').setup {
    filewatching = 'roslyn',
    broad_search = true,
  }
end

return M
