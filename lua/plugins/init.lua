require('packer').startup({
    -- add plugins
    function(use)
        -- impatient.nvim
        use {
            'lewis6991/impatient.nvim',
            config = [[require('impatient')]]
        }

        -- Packer can manage itself
        use {'wbthomason/packer.nvim'}

        -- UI hooks
        use {'stevearc/dressing.nvim'}

        -- colorscheme
        -- use {
        --     'shaunsingh/nord.nvim',
        --     config = [[vim.cmd('colorscheme nord')]]
        -- }
        use {
            'folke/tokyonight.nvim',
            config = function ()
                vim.g.tokyonight_style='storm'
                vim.g.tokyonight_lualine_bold=true
                vim.cmd('colorscheme tokyonight')
            end
        }

        -- lualine
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons' },
            config = [[require('plugins/config/lualine').setup()]]
        }

        -- nvim-tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = { 'kyazdani42/nvim-web-devicons' },
            cmd = 'NvimTreeToggle',
            config = [[require('nvim-tree').setup{}]]
        }

        -- telescope
        -- install rg and fd to improve performance:
        --     rg -> https://github.com/BurntSushi/ripgrep/releases
        --     fd -> https://github.com/sharkdp/fd/releases
        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = [[require('plugins/config/telescope').setup()]]
        }
        -- telescope extensions
        -- telescope-fzf-native
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
        -- session manager
        use {
            'Shatur/neovim-session-manager',
            after = 'telescope.nvim',
            config = [[require('telescope').load_extension('sessions')]]
        }

        -- snippet
        use {
            {
                "SirVer/ultisnips",
                event = 'BufEnter',
                setup = function()
                    vim.g.UltiSnipsExpandTrigger = '<C-j>'
                    vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
                    vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'
                    vim.g.UltiSnipsListSnippets='<C-l>'
                end
            },
            { "honza/vim-snippets", after = 'ultisnips'}
        }

        -- nvim-cmp
        use {
            {
                'hrsh7th/nvim-cmp',
                event = 'BufEnter',
                config = [[require('plugins/config/nvim-cmp').setup()]]
            },
            -- nvim-cmp completion sources
            {'hrsh7th/cmp-path', after = 'nvim-cmp'},
            {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
            {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'},
            {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'},
            {
                'quangnguyen30192/cmp-nvim-ultisnips',
                after = {'nvim-cmp', 'ultisnips'}
            },
        }

        -- nvim-lspconfig
        use {
            'neovim/nvim-lspconfig',
            after = 'cmp-nvim-lsp',
            config = [[require('plugins/config/lsp').setup()]]
        }

        -- tasks
        use {
            'skywind3000/asynctasks.vim',
            requires = 'skywind3000/asyncrun.vim',
            setup = [[require('plugins/config/asynctasks').setup()]]
        }

        -- markdown
        use {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            cmd = 'MarkdownPreview',
            setup = function()
                vim.g.mkdp_auto_close=0
                vim.api.nvim_set_keymap(
                'n',
                '<Leader>p',
                '<Plug>MarkdownPreviewToggle',
                {noremap=false}
                )
            end
        }

        -- comment
        use {
            'numToStr/Comment.nvim',
            config = function ()
                require('Comment').setup {
                    mappings = {
                        basic=true,
                        extra=false,
                        extended=false,
                    },
                }
            end
        }

        -- surround
        use {
            'machakann/vim-sandwich',
            event = 'BufEnter',
            setup = function ()
                local map = vim.api.nvim_set_keymap
                map('n', 's', '<Nop>',{})
                map('x', 's', '<Nop>',{})
            end
        }

        -- text object
        use {
            'kana/vim-textobj-user',
            'kana/vim-textobj-indent',
            'sgur/vim-textobj-parameter'
        }
    end,

    -- config packer
    config={
        compile_path=vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        },
        profile = {enable=true},
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
