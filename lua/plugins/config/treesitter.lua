local M = {}

M.setup = function()
  require('nvim-treesitter.configs').setup{
    ensure_installed = {'c', 'cpp', 'cmake', 'python',
                        'latex', 'lua', 'make', 'vim'},
    highlight = {
      enable = true,
    },
  }
end

return M
