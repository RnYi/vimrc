local M={}

M.keybind = function ()
    vim.keymap.set('n','<Leader>e','<Cmd>Neotree source=filesystem toggle=true<CR>',{desc='Toggle neo-tree'})
end

M.setup=function ()
    vim.g.neo_tree_remove_legacy_commands=1
    require('neo-tree').setup({
        enable_git_status=true,
        enable_diagnostics=false,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        source_selector={
            winbar=true
        }
    })
end

return M
