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
        -- install rg and fd to improve performance:
        -- rg -> https://github.com/BurntSushi/ripgrep/releases
        -- fd -> https://github.com/sharkdp/fd/releases
        use {
            'nvim-telescope/telescope.nvim',
            requires = { {'nvim-lua/plenary.nvim'} },
            cmd = 'Telescope',
            config = pconf.telescope_setup
        }
        -- telescope extensions
        if vim.g.sys_uname=='win' then
            use {
                'Leandros/telescope-fzf-native.nvim',
                branch = 'feature/windows_build_support',
                run = 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && '..
                      'cmake --build build --config Release && '..
                      'cmake --install build',
                after = 'telescope.nvim',
                config = [[require('telescope').load_extension('fzf')]]
            }
        else
            use {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
                after = 'telescope.nvim',
                config = [[require('telescope').load_extension('fzf')]]
            }
        end

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
