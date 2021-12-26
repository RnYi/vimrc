local M = {}

M.keybind = function ()
  vim.api.nvim_set_keymap(
  'n', '<Leader>e',
  '<Cmd>NvimTreeToggle<CR>',
  {noremap=true, silent=true}
  )
end

M.setup = function ()
  require('nvim-tree').setup {
    update_cwd = true,
    git = {
      enable = false
    },
    view = {
      auto_resize = true,
    },
  }
end


return M
