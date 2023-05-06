local M = {}

M.setup = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'cmake', 'python',
            'latex', 'lua', 'make', 'markdown', 'vim', 'vimdoc',
            'toml', 'yaml', 'bibtex', },
        highlight = {
            enable = true,
            disable = function(lang, buf)
                if vim.g.nvim_env=='vscode' then
                    return true
                end
                local max_filesize = 100 * 1024
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                },
                selection_modes = {
                    ['@class.outer'] = 'V',
                },
            },
        }
    }
end

return M
