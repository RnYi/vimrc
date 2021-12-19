---------------
--  Prepare  --
---------------
local pl_conf=require('plugins/plugins_config')

---------------
--  Plugins  --
---------------
-- Load packer.nvim
vim.cmd('packadd packer.nvim')
require('packer').startup({
    function(use)
        -- impatient.nvim
        use {
            'lewis6991/impatient.nvim',
            config = [[require('impatient')]]
        }
        -- packer.nvim can manage itself
        use {
            'wbthomason/packer.nvim',
            opt=true
        }

        -- nord colorscheme
        use {
            'shaunsingh/nord.nvim',
            event='VimEnter',
            config = [[vim.cmd('colorscheme nord')]]
        }

        -- lualine
        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons'
            },
            event='VimEnter',
            config = pl_conf.lualine_setup
        }

        -- telescope
        use {
            'nvim-telescope/telescope.nvim',
            cmd = 'Telescope',
            requires = { {'nvim-lua/plenary.nvim'} },
            config = pl_conf.telescope_setup
        }

        -- nvim-cmp

    end,

    config={
        compile_path=vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
        git={
            -- use fastgit for git clone
            default_url_format='https://hub.fastgit.org/%s'
        }
    }
})

-- impatient.nvim requires to load packer_compiled manually
local status, _ = pcall(require, 'packer_compiled')
if not status then
    print('Failed to require packer_compiled.lua!')
end
