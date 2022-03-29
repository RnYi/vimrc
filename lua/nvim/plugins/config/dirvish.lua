local M = {}

M.keybind = function ()
  vim.keymap.set('n', '<Leader>e', '<Cmd>tabnew|Dirvish<CR>')
end

M.setup = function ()
  
end

return M
