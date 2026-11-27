local M = {}

function M.setup()
  require('flutter-tools').setup {}
  local map = function(lhs, command, desc)
    vim.keymap.set('n', lhs, '<cmd>' .. command .. '<cr>', { desc = desc })
  end
  map('<leader>afc', 'FlutterCommands', 'Flutter commands')
  map('<leader>afr', 'FlutterRun', 'Flutter run')
  map('<leader>afl', 'FlutterReload', 'Flutter hot reload')
  map('<leader>aft', 'FlutterRestart', 'Flutter hot restart')
  map('<leader>afq', 'FlutterQuit', 'Flutter quit')
  map('<leader>afd', 'FlutterDevices', 'Flutter devices')
  map('<leader>afe', 'FlutterEmulators', 'Flutter emulators')
  map('<leader>afo', 'FlutterOutlineToggle', 'Toggle Flutter outline')
  map('<leader>afp', 'FlutterPubGet', 'Flutter pub get')
end

return M
