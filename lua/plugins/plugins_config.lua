local M={}

---------------
--  lualine  --
---------------
M.lualine_setup = function ()
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

return M
