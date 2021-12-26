local M = {}

M.keybind = function ()
  local map=vim.api.nvim_set_keymap
  local map_opt = {noremap=true, silent=true}
  map(
    'n',
    '[b',
    '<Cmd>BufferPrevious<CR>',
    map_opt
    )
  map(
    'n',
    ']b',
    '<Cmd>BufferNext<CR>',
    map_opt
    )
  map(
    'n',
    '<M-d>',
    '<Cmd>BufferClose<CR>',
    map_opt
    )
  map(
    'n',
    '<Leader>p',
    '<Cmd>BufferPick<CR>',
    map_opt
    )
end

M.setup = function ()
  vim.g.bufferline = {
    closable = false,
  }
end

return M
