local M = {}

M.keybind = function ()
  local map = vim.api.nvim_set_keymap
  local map_opt = {noremap = true, silent = true}
  map('n', '<Leader>vv', '<Cmd>Vista<CR>', map_opt)
  map('n', '<Leader>vl', '<Cmd>Vista nvim_lsp<CR>', map_opt)
end

M.setup = function ()
  vim.g.vista_echo_cursor=0
  vim.g.vista_blink={0,0}
  vim.g.vista_cursor_delay=300
  vim.g.vista_executive_for = {
    ['markdown'] = 'toc',
  }
end

return M
