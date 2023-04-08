local M = {}

M.keybind = function()
    vim.keymap.set(
        'n', '<Leader>e',
        '<Cmd>NvimTreeToggle<CR>',
        { noremap = true, silent = true }
    )
end

M.on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    api.config.mappings.default_on_attach(bufnr)
    if OSName ~= 'win' then
        return
    end
    local function trash_path()
        local node = api.tree.get_node_under_cursor()
        local notify = require('nvim-tree.notify')
        local events = require('nvim-tree.events')
        local err_msg = ''
        local function on_stderr(_, data)
            err_msg = err_msg .. (data and table.concat(data, " "))
        end

        local function on_exit(_, rc)
            if rc ~= 0 then
                notify.warn("trash failed: " .. err_msg)
                return
            end
            if node.nodes ~= nil and not node.link_to then
                events._dispatch_folder_removed(node.absolute_path)
            else
                events._dispatch_file_removed(node.absolute_path)
                -- clear_buffer(node.absolute_path)
            end
            require('nvim-tree.actions.reloaders.reloaders').reload_explorer()
        end

        local trash_cmd = '!pwsh.exe' .. ' -WindowStyle Hidden -NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'.. ' "' .. 'Remove-ItemSafely ' .. node.absolute_path .. '"'
        vim.api.nvim_command('silent ' .. trash_cmd)
        -- vim.fn.jobstart(trash_cmd, {
        --     detach = true,
        --     on_exit = on_exit,
        --     on_stderr = on_stderr,
        -- })
    end

    local function opts(desc) -- option of keymap
        return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Customize keymaps
    vim.keymap.set('n', 'd', trash_path, opts('Trash'))
end

M.setup = function()
    -- local tree_cb = require('nvim-tree.config').nvim_tree_callback
    require('nvim-tree').setup {
        on_attach = M.on_attach,
        sync_root_with_cwd = true,
        -- reload_on_bufenter = true,
        respect_buf_cwd = true,
        select_prompts = true,
        git = {
            ignore = false,
        },
        view = {
            hide_root_folder = true,
        },
        renderer = {
            group_empty = true,
            icons = {
                git_placement = 'signcolumn',
            },
        },
        actions = {
            change_dir = {
                global = true
            }
        },
        tab = {
            sync = {
                open = true,
                close = true,
            },
        },
    }
end


return M
