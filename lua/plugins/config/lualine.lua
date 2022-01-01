local M = {}

M.setup = function()
  vim.opt.showmode=false
  -- status of 'paste'
  function PasteStatus()
    if vim.o.paste then
      return '[P]'
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
      lualine_b = {
        'branch',
        'diff',
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
      },
      lualine_c = {
        'filename',
        PasteStatus,
      },
      lualine_y = {},
      lualine_z = {},

    }
  }
end

return M
