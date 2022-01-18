local M = {}

M.setup = function()
    -- vim.cmd([[
    -- augroup AsyncTasks
    --     autocmd!
    --     autocmd BufRead,BufNewFile .tasks set filetype=tasks
    --     autocmd BufRead,BufNewFile tasks.ini set filetype=tasks
    -- augroup END
    -- ]])
    vim.g.asyncrun_open=6
    vim.g.asynctasks_term_pos='TAB'
    vim.g.asynctasks_term_reuse=1
    vim.g.asynctasks_config_name='.asynctasks'
    vim.g.asynctasks_rtp_config='asynctasks.ini'
    vim.g.asynctasks_extra_config={NvimHome..'/asynctasks.ini'}
    vim.g.asyncrun_rootmarks={'.root','.project','.git','.hg',
                              '.svn','.projections.json'}
    vim.g.asynctasks_template={}
end

M.keybind = function ()
    local map=vim.api.nvim_set_keymap
    local map_opt={noremap=true, silent=true}
    map('n', '<F3>', '<Cmd>AsyncTask build<CR>', map_opt)
    map('i', '<F3>', '<Esc><Cmd>AsyncTask build<CR>', map_opt)
    map('n', '<F4>', '<Cmd>AsyncTask run<CR>', map_opt)
    map('i', '<F4>', '<Esc><Cmd>AsyncTask run<CR>', map_opt)
    map('n', '<F5>', '<Cmd>AsyncTask debug<CR>', map_opt)
    map('i', '<F5>', '<Esc><Cmd>AsyncTask debug<CR>', map_opt)
    map('n', '<F6>', '<Cmd>AsyncTask git-add-commit<CR>', map_opt)
    map('i', '<F6>', '<Esc><Cmd>AsyncTask git-add-commit<CR>', map_opt)
end

return M
