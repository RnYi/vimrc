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
    require('plugins/nvim-cmp')
end

-----------------
--  lspconfig  --
-----------------
M.lsp_setup = function ()
    require('plugins/lsp')
end

return M
