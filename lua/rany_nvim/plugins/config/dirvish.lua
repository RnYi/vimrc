local M = {}

M.keybind = function ()
  vim.keymap.set('n', '<Leader>e', '<Cmd>Dirvish<CR>')
end

M.setup = function ()
  vim.cmd[[
  let g:dirvish_mode=':sort ,^.*[\/],'
  ]]
end

return M
