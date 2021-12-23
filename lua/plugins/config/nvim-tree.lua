local M = {}

M.setup = function ()
    require('nvim-tree').setup {

    }
end

M.keybind = function ()
    vim.api.nvim_set_keymap(
        'n', '<Leader>e',
        '<Cmd>NvimTreeToggle<CR>',
        {noremap=true, silent=true}
    )
end

return M
