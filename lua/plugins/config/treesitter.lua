local M = {}

M.setup = function()
  require('nvim-treesitter.configs').setup{
    ensure_installed = {'c', 'cpp', 'cmake', 'python',
                        'latex', 'lua', 'make', 'vim',
                        'toml', 'bibtex',},
    highlight = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['al'] = '@class.outer',
          ['il'] = '@class.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['ac'] = '@call.outer',
          ['ic'] = '@call.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<Leader>sa'] = '@parameter.inner',
        },
        swap_previous = {
          ['<Leader>sA'] = '@parameter.inner',
        },
      },
    },
  }
end

return M
