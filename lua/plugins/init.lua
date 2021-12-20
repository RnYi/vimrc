---------------
--  Prepare  --
---------------
local pconf=require('plugins/plugins_config')

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
            opt = true
        }

        -- colorscheme
        use {
            'shaunsingh/nord.nvim',
            event = 'VimEnter',
            config = [[vim.cmd('colorscheme nord')]]
        }

        -- lualine
        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons'
            },
            event = 'VimEnter',
            config = pconf.lualine_setup
        }

        -- telescope
        use {
            'nvim-telescope/telescope.nvim',
            cmd = 'Telescope',
            requires = { {'nvim-lua/plenary.nvim'} },
            config = pconf.telescope_setup
        }

        -- snippet
        use {
            "SirVer/ultisnips",
            event = 'BufEnter',
            setup = pconf.ultisnips_setup
        }
        use({ "honza/vim-snippets", after = 'ultisnips'})

        -- nvim-cmp
        use {
            'hrsh7th/nvim-cmp',
            event = 'BufEnter',
            config = pconf.nvim_cmp_setup
        }
        -- nvim-cmp completion sources
        use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
        use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
        use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}
        use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'}
        use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'}
        use {
            'quangnguyen30192/cmp-nvim-ultisnips',
            after = {'nvim-cmp', 'ultisnips'}
        }

        -- nvim-lspconfig
        use {
            'neovim/nvim-lspconfig',
            after = 'cmp-nvim-lsp',
            config = pconf.lsp_setup
        }
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
    vim.api.nvim_echo({{'Failed to require packer_compiled.lua!', 'Error'}}, true, {})
end
