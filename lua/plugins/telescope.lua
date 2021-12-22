local M = {}
-- key bindings
M.keybind = function()
    local map=vim.api.nvim_set_keymap
    local map_opt={noremap=true, silent=true}
    -- find_files
    map('n',
    '<Leader>ff',
    [[<Cmd>Telescope find_files<CR>]],
    map_opt)
    -- live_grep
    map('n',
    '<Leader>g',
    [[<Cmd>Telescope live_grep<CR>]],
    map_opt)
    -- buffers
    map('n',
    '<Leader>b',
    [[<Cmd>Telescope buffers<CR>]],
    map_opt)
    -- file_browser
    map('n',
    '<Leader>e',
    [[<Cmd>Telescope file_browser<CR>]],
    map_opt)
    -- sessions
    map('n',
    '<Leader>s',
    [[<Cmd>Telescope sessions save_current=true<CR>]],
    map_opt)

    -- lsp_definitions
    map('n',
    'gd',
    [[<Cmd>Telescope lsp_definitions<CR>]],
    map_opt)
    -- lsp_references
    map('n',
    'gr',
    [[<Cmd>Telescope lsp_references<CR>]],
    map_opt)
    -- lsp_type_definitions
    map('n',
    'gy',
    [[<Cmd>Telescope lsp_type_definitions<CR>]],
    map_opt)
    -- diagnostics for current buffer
    map('n',
    '<Leader>dl',
    [[<Cmd>Telescope diagnostics bufnr=0<CR>]],
    map_opt)
    -- diagnostics for all buffers
    map('n',
    '<Leader>dL',
    [[<Cmd>Telescope diagnostics<CR>]],
    map_opt)
end

-- setup
M.setup=function()
local action_layout = require('telescope.actions.layout')
require('telescope').setup {
    defaults = {
        path_display = {
            smart = true
        },
        dynamic_preview_title = true,
        mappings = {
            n = {
                ["<M-p>"] = action_layout.toggle_preview,
                ["cd"] = function(prompt_bufnr)
                    local selection = require("telescope.actions.state").get_selected_entry()
                    local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                    -- Depending on what you want put `cd`, `lcd`, `tcd`
                    vim.cmd(string.format("tcd %s", dir))
                end
            },
            i = {
                ["<M-p>"] = action_layout.toggle_preview
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        file_browser = {
            initial_mode = 'normal',
        },
        diagnostics = {
            initial_mode = 'normal',
        },
        lsp_definitions = {
            initial_mode = 'normal',
            jump_type = 'vsplit',
            ignore_filename = false,
        },
        lsp_type_definitions = {
            initial_mode = 'normal',
            jump_type = 'vsplit',
            ignore_filename = false,
        },
    },
}
end

-- return function keybind
return M
