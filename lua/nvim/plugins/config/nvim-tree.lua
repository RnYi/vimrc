local M = {}

M.keybind = function ()
  vim.keymap.set(
  'n', '<Leader>e',
  '<Cmd>NvimTreeToggle<CR>',
  {noremap=true, silent=true}
  )
end

M.setup = function ()
  local trash_cmd = 'trash'
  if vim.g.sys_uname=='win' then
    -- Install trash cmd on Powershell
    --    -> Install-Module -Name Recycle
    trash_cmd = 'Remove-ItemSafely'
  end
  local tree_cb = require('nvim-tree.config').nvim_tree_callback
  require('nvim-tree').setup {
    update_cwd = true,
    git = {
      enable = false
    },
    view = {
      auto_resize = true,
      hide_root_folder = true,
      mappings = {
        list = {
          { key = 'd', cb = tree_cb('trash') },
          { key = 'D', cb = tree_cb('remove') },
        },
      },
    },
    trash = {
      cmd = trash_cmd,
    },
  }
end


return M
