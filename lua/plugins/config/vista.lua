local M = {}

M.keybind = function ()
  local map = vim.api.nvim_set_keymap
  local map_opt = {noremap = true, silent = true}
  map('n', '<Leader>vv', '<Cmd>Vista!!<CR>', map_opt)
end

M.setup = function ()
  vim.g.vista_echo_cursor=0
  vim.g.vista_blink={1,300}
  vim.g.vista_cursor_delay=300
  vim.g.vista_default_executive = 'nvim_lsp'
  vim.g.vista_ignore_kinds = {'variable'}
  vim.g.vista_executive_for = {
    ['markdown'] = 'toc',
  }
end

return M
