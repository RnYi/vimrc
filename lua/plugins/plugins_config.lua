local M={}
---------------
--  lualine  --
---------------
M.lualine_setup = function ()
    vim.opt.showmode=false
    require('lualine').setup {
        options={ theme='nord' },
        extensions={ 'quickfix', 'nvim-tree' }
    }
end

-----------------
--  telescope  --
-----------------
M.telescope_setup = function ()
    require('plugins/telescope').setup()
end

-----------------
--  ultisnips  --
-----------------
M.ultisnips_setup = function ()
    vim.g.UltiSnipsExpandTrigger = '<C-j>'
    vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
    vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'
    vim.g.UltiSnipsListSnippets='<C-l>'
end

----------------
--  nvim-cmp  --
----------------
M.nvim_cmp_setup = function ()
    require('plugins/nvim-cmp').setup()
end

-----------------
--  lspconfig  --
-----------------
M.lsp_setup = function ()
    require('plugins/lsp').setup()
end

------------------
--  asynctasks  --
------------------
M.asynctasks_setup = function ()
    vim.cmd([[
    augroup AsyncTasks
        autocmd!
        autocmd BufRead,BufNewFile .tasks set filetype=tasks
        autocmd BufRead,BufNewFile tasks.ini set filetype=tasks
    augroup END
    ]])
    vim.g.asyncrun_open=6
    vim.g.asynctasks_term_pos='right'
    vim.g.asynctasks_term_reuse=1
    vim.g.asynctasks_extra_config={NvimHome..'/tasks.ini'}
    vim.g.asyncrun_rootmarks={'.root','.project','.git','.hg',
                              '.svn','.projections.json'}
    vim.g.asynctasks_template={}
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
    map('n', '<F7>', '<Cmd>AsyncTask git-add-commit-push<CR>', map_opt)
    map('i', '<F7>', '<Esc><Cmd>AsyncTask git-add-commit-push<CR>', map_opt)
end

------------------------
--  markdown-preview  --
------------------------
M.mkdp_setup = function()
    vim.g.mkdp_auto_close=0
    vim.api.nvim_set_keymap(
        'n',
        '<Leader>p',
        '<Plug>MarkdownPreviewToggle',
        {noremap=false}
        )
end


return M
