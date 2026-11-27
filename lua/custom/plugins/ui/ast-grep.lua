local M = {}

local languages = {
  sh = 'bash', bash = 'bash', c = 'c', cpp = 'cpp', cs = 'csharp',
  css = 'css', elixir = 'elixir', go = 'go', haskell = 'haskell',
  hcl = 'hcl', html = 'html', java = 'java', javascript = 'javascript',
  javascriptreact = 'javascript', json = 'json', kotlin = 'kotlin', lua = 'lua',
  markdown = 'markdown', nix = 'nix', php = 'php', python = 'python',
  ruby = 'ruby', rust = 'rust', scala = 'scala', solidity = 'solidity',
  swift = 'swift', typescript = 'typescript', typescriptreact = 'tsx',
  yaml = 'yaml', zig = 'zig',
}

local function open(language)
  local executable = vim.fn.exepath 'ast-grep'
  if vim.fn.has 'win32' == 1 then
    local mason_exe = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'packages', 'ast-grep', 'ast-grep.exe')
    if vim.fn.executable(mason_exe) == 1 then
      executable = mason_exe
    end
  end
  if executable == '' then
    vim.notify('ast-grep is not installed yet. Run :MasonToolsInstall and try again.', vim.log.levels.WARN)
    return
  end

  Snacks.picker.pick {
    title = 'AST Grep (' .. language .. ')',
    format = 'file',
    live = true,
    supports_live = true,
    show_empty = true,
    finder = function(opts, ctx)
      local pattern = ctx.filter.search
      if pattern == '' then
        return function() end
      end
      return function(cb)
        local async = require('snacks.picker.util.async').running()
        local result
        local process = vim.system(
          { executable, 'run', '--json=stream', '--lang', language, '--pattern=' .. pattern, '.' },
          { text = true, cwd = opts.cwd or ctx.filter.cwd },
          function(output)
            result = output
            async:resume()
          end
        )
        async:on('abort', function()
          pcall(process.kill, process, 15)
        end)
        while not result do
          async:suspend()
        end
        for output in (result.stdout or ''):gmatch('[^\r\n]+') do
          local ok, match = pcall(vim.json.decode, output)
          if not ok or not match.file or not match.range or not match.range.start then
            goto continue
          end
          local start = match.range.start
          local line = (match.lines or match.text or ''):match('[^\r\n]*') or ''
          cb {
            file = match.file,
            cwd = opts.cwd or ctx.filter.cwd,
            pos = { start.line + 1, start.column },
            line = line,
            text = ('%s:%d:%d: %s'):format(match.file, start.line + 1, start.column + 1, line),
          }
          ::continue::
        end
      end
    end,
  }
end

function M.search()
  local ft = vim.bo.filetype
  local language = languages[ft]
  if language then
    open(language)
    return
  end
  vim.ui.input({ prompt = 'ast-grep language (unsupported filetype: ' .. ft .. '): ' }, function(input)
    if input and input ~= '' then
      open(input)
    end
  end)
end

return M
