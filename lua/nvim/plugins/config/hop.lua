local M = {}

M.keybind = function ()
 local map = vim.keymap.set
  local map_opt = {noremap=true, silent=true}
  map(
    'n',
    's',
    '<Cmd>HopChar2<CR>',
    map_opt
    )
  map(
    'x',
    's',
    '<Cmd>HopChar2<CR>',
    map_opt
    )
end

M.setup = function ()
  require('hop').setup{
    char2_fallback_key='<CR>'
  }
end

return M
