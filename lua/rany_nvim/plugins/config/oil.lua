local M={}

M.keybind=function ()
    vim.keymap.set('n','<Leader>e','<Cmd>Oil<CR>')
end

M.setup=function ()
    require('oil').setup({
        columns={
            'icon',
            -- 'mtime',
        }
    })
end

return M
