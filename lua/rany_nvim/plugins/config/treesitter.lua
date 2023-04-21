local M = {}

M.setup = function()
  require('nvim-treesitter.configs').setup{
    ensure_installed = {'c', 'cpp', 'cmake', 'python',
                        'latex', 'lua', 'make','markdown', 'vim','vimdoc',
                        'toml', 'yaml', 'bibtex',},
    highlight = {
      enable = true,
    },
    -- textobjects = {
    --   select = {
    --     enable = true,
    --     lookahead = true,
    --     keymaps = {
    --       ['aa'] = '@parameter.outer',
    --       ['ia'] = '@parameter.inner',
    --       ['ab'] = '@block.outer',
    --       ['ib'] = '@block.inner'
    --     },
    --   },
      -- move = {
      --   enable = true,
      --   set_jumps = true,
      --   goto_next_start = {
      --     [']m'] = '@function.outer',
      --     [']]'] = '@class.outer',
      --   },
      --   goto_next_end = {
      --     [']M'] = '@function.outer',
      --     [']['] = '@class.outer',
      --   },
      --   goto_previous_start = {
      --     ['[m'] = '@function.outer',
      --     ['[['] = '@class.outer',
      --   },
      --   goto_previous_end = {
      --     ['[M'] = '@function.outer',
      --     ['[]'] = '@class.outer',
      --   },
      -- },
    -- }
  }
end

return M
