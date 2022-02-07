local M = {}

M.keybind = function ()
  local map = vim.keymap.set
  local map_opt = {noremap=true, silent=true}
  map('n', '<Leader>gs', '<Cmd>Git<CR>', map_opt)
end

M.setup = function ()
end

return M
