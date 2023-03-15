local M = {}

M.setup = function()
  vim.opt.showmode=false
  -- paste status
  function Paste_Indicator()
    if vim.o.paste then
      return 'PASTE'
    end
    return ''
  end
  require('lualine').setup {
    options={
      theme='auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      always_divide_middle = false,
    },
    extensions={ 'quickfix', 'nvim-tree', 'fugitive' },
    sections = {
      lualine_a = {
        {
          'mode',
          separator = '|',
        },
        Paste_Indicator,
      },
      lualine_b = {
        'branch',
        'diff',
      },
      lualine_c = {
        'filename',
        -- diagnostic
        {
          'diagnostics',
          symbols = {
            error = '',
            warn = '',
            info='',
            hint = ''
          },
          diagnostics_color = {
            error = 'DiagnosticSignError',
            warn = 'DiagnosticSignWarn',
            info = 'DiagnosticSignInfo',
            hint = 'DiagnosticSignHint',
          },
        },
        -- coc
        {
          'g:coc_status',
          cond = function ()
            return vim.g.did_coc_loaded ~= nil
          end
        },
        -- gutentags
        {
          "gutentags#statusline('[', ']')",
          cond = function ()
            return vim.g.loaded_gutentags ~= nil
          end
        },
      },
      lualine_y = {},
      lualine_z = {},

    }
  }
end

return M
