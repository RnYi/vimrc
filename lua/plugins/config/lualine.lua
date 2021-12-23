local M = {}

M.setup = function()
    vim.opt.showmode=false
    require('lualine').setup {
        options={
            theme='auto',
            section_separators = '',
            always_divide_middle = false,
        },
        sections = {
            lualine_b = {'branch'},
            lualine_c = {
                'filename',
                'diff',
                {
                    'diagnostics',
                    symbols = {
                        error = ' ',
                        warn = ' ',
                        info=' ',
                        hint = ' '
                    },
                },
            },
            lualine_y = {},
            lualine_z = {},

        },
        extensions={ 'quickfix', 'nvim-tree' }
    }
end

return M
