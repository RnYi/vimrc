local M = {}

M.keybind = function ()
 local map = vim.api.nvim_set_keymap
  local map_opt = {noremap=true, silent=true}
  map(
    'n',
    '<Leader>s',
    '<Cmd>HopChar2<CR>',
    map_opt
    )
  map(
    'x',
    '<Leader>s',
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
