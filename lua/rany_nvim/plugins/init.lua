local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        vim.g.repo_url .. "/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
local function conf(name)
    local conf_path = ([[rany_nvim.plugins.config.%s]]):format(name)
    return require(conf_path).setup
end
require('lazy').setup({
        -- plugins

        -- impatient.nvim
        {
            'lewis6991/impatient.nvim',
            lazy = false,
            config = function()
                require('impatient')
            end
        },
        -- Faster filetype
        -- { 'nathom/filetype.nvim',    lazy = false },

        -- UI hooks
        {
            'stevearc/dressing.nvim',
            event = 'VimEnter',
            opts = {
                input = {
                    win_options = {
                        -- window transparency
                        winblend = 0,
                    }
                }
            }
        },

        -- Treesitter
        {
            'nvim-treesitter/nvim-treesitter',
            event = 'VimEnter',
            build = ':TSUpdate',
            config = conf('treesitter')
        },
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            event = 'VimEnter'
        },

        -- Colorscheme
        {
            'sainnhe/gruvbox-material',
            event = 'VimEnter',
            config = function()
                vim.g.gruvbox_material_better_performance = 1
                vim.g.gruvbox_material_enable_bold = 1
                vim.g.gruvbox_material_enable_italic = 1
                vim.g.gruvbox_material_disable_italic_comment = 1
                vim.g.gruvbox_material_visual = 'blue background'
                vim.g.gruvbox_material_menu_selection_background = 'blue'
                vim.g.gruvbox_material_disable_italic_comment = 1
                vim.g.gruvbox_material_sign_column_background = 'none'
                vim.g.gruvbox_material_transparent_background = 0
                vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
                vim.cmd('colorscheme gruvbox-material')
            end
        },

        -- Statusline
        {
            'nvim-lualine/lualine.nvim',
            dependencies = {
                'nvim-tree/nvim-web-devicons',
                'sainnhe/gruvbox-material'
            },
            event = 'VimEnter',
            config = conf('lualine')
        },

        -- Tabline
        {
            'crispgm/nvim-tabline',
            event = 'VimEnter',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            config = function()
                require('tabline').setup({
                    show_icon = true,
                    brackets = { '', '' }
                })
            end,
        },

        -- Lsp status
        {
            'j-hui/fidget.nvim',
            enabled = function()
                return vim.g.comp_plug == 'lsp'
            end,
            event = 'VimEnter',
            dependencies = { 'neovim/nvim-lspconfig' },
            config = true,
        },

        -- Quickfix
        {
            'kevinhwang91/nvim-bqf',
            ft = 'qf',
            opts = {
                preview = {
                    auto_preview = false,
                },
                func_map = {
                    tabc = '',
                    tabdrop = '<C-t>',
                    pscrollup = '<C-u>',
                    pscrolldown = '<C-d>',
                    split = '<C-s>'
                }
            }
        },

        -- File Explorer
        {
            'stevearc/oil.nvim',
            cmd = 'Oil',
            config = conf('oil')
        },
        -- {
        --     "nvim-neo-tree/neo-tree.nvim",
        --     branch = 'v2.x',
        --     cmd='Neotree',
        --     dependencies = {
        --         'nvim-lua/plenary.nvim',
        --         'nvim-tree/nvim-web-devicons',
        --         "MunifTanjim/nui.nvim",
        --     },
        --     config=conf('neo-tree')
        -- },
        -- {
        --     'kyazdani42/nvim-tree.lua',
        --     cmd = 'NvimTreeToggle',
        --     config = conf('nvim-tree')
        -- },

        -- Search and Move
        {
            'phaazon/hop.nvim',
            cmd = { 'HopWord', 'HopPattern', 'HopChar1', 'HopChar2', 'HopLine' },
            config = conf('hop')
        },

        -- Git
        {
            'tpope/vim-fugitive',
            cmd = { 'G', 'Git', 'Gedit', 'Gread', 'Gwrite', 'Gdiffsplit', 'Gvdiffsplit' },
            init = conf('fugitive')
        },

        -- Telescope
        -- install rg and fd to improve performance:
        --     rg -> https://github.com/BurntSushi/ripgrep/releases
        --     fd -> https://github.com/sharkdp/fd/releases
        {
            'nvim-telescope/telescope.nvim',
            event = 'VimEnter',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = conf('telescope')
        },
        -- Telescope extensions
        -- Telescope-fzf-native
        -- {
        --    'Leandros/telescope-fzf-native.nvim',
        --    branch = 'feature/windows_build_support',
        --    enabled=function()
        --        return vim.g.sys_uname=='win'
        --    end,
        --    build = 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && ' ..
        --        'cmake --build build --config Release && ' ..
        --        'cmake --install build',
        --    dependencies = {'telescope.nvim'},
        --    config=function ()
        --        require('telescope').load_extension('fzf')
        --    end,
        -- },

        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            event = 'VimEnter',
            dependencies = { 'telescope.nvim' },
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },

        -- Session manager
        {
            'Shatur/neovim-session-manager',
            event = 'VimEnter',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                -- keymap
                vim.keymap.set('n', '<Leader>sl', '<Cmd>SessionManager load_session<CR>', { desc = 'Load session' })
                vim.keymap.set('n', '<Leader>ss', '<Cmd>SessionManager save_current_session<CR>',
                    { desc = 'Save session' })
                vim.keymap.set('n', '<Leader>sd', '<Cmd>SessionManager delete_session<CR>', { desc = 'Delete session' })
                -- config
                require('session_manager').setup({
                    autosave_only_in_session = true,
                })
            end
        },

        -- Handle delimiters
        {
            'windwp/nvim-autopairs',
            event = 'VimEnter',
            config = true
        },

        -- Snippet
        {
            'dcampos/nvim-snippy',
            dependencies = { 'honza/vim-snippets' },
            enabled = function()
                return vim.g.comp_plug == 'lsp'
            end,
            config = function()
                require('snippy').setup({
                    mappings = {
                        is = {
                            ['<C-j>'] = 'expand_or_advance',
                            ['<C-k>'] = 'previous',
                        },
                    }
                })
            end
        },
        {
            'SirVer/ultisnips',
            dependencies = { 'honza/vim-snippets' },
            enabled = function()
                return vim.g.comp_plug == 'coc'
            end,
            init = function()
                vim.g.UltiSnipsExpandTrigger = "<C-j>"
                vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
                vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
            end
        },

        ----------------
        -- Completion --
        ----------------
        -- nvim-lspconfig
        {
            'neovim/nvim-lspconfig',
            dependencies = { 'hrsh7th/cmp-nvim-lsp' },
            enabled = function()
                return vim.g.comp_plug == 'lsp'
            end,
            config = conf('lsp')
        },
        -- nvim-cmp
        {
            'hrsh7th/nvim-cmp',
            enabled = function()
                return vim.g.comp_plug == 'lsp'
            end,
            event = 'VimEnter',
            dependencies = {
                'neovim/nvim-lspconfig',
                'onsails/lspkind-nvim',
                'dcampos/nvim-snippy',
                'dcampos/cmp-snippy',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lua'
            },
            config = conf('nvim-cmp')
        },

        -- coc.nvim
        {
            'neoclide/coc.nvim',
            branch = 'release',
            event='VimEnter',
            dependencies={'SirVer/ultisnips'},
            enabled = function()
                return vim.g.comp_plug == 'coc'
            end,
            init = conf('coc')
        },

        -- Tag
        -- install gtags:
        --  -> http://adoxa.altervista.org/global/  (Windows)
        -- install ctags:
        --  -> https://github.com/universal-ctags/ctags-win32/releases  (Windows)
        --  {
        --   'ludovicchabant/vim-gutentags',
        --   event = 'VimEnter',
        --   setup = require('nvim.plugins.config.gutentags').setup
        -- }
        --  {
        --   'skywind3000/gutentags_plus',
        --   after = 'vim-gutentags',
        --   setup = function ()
        --     -- key map prefix is <Leader>c
        --     -- s: Find this symbol
        --     -- g: Find this definition
        --     -- d: Find functions called by this function
        --     -- c: Find functions calling this function
        --     -- t: Find this text string
        --     -- e: Find this egrep pattern
        --     -- f: Find this file
        --     -- i: Find files #including this file
        --     -- a: Find places where this symbol is assigned a value
        --     g.gutentags_plus_switch = 1
        --   end
        -- }

        -- Symbol
        --  {
        --   'liuchengxu/vista.vim',
        --   cmd = 'Vista',
        --   setup = conf('vista')
        -- }

        -- Tasks
        {
            'skywind3000/asynctasks.vim',
            dependencies = { 'skywind3000/asyncrun.vim' },
            event = 'VimEnter',
            init = conf('asynctasks')
        },

        -- Markdown
        {
            'iamcco/markdown-preview.nvim',
            build = 'cd app && yarn install',
            ft = 'markdown',
            init = function()
                vim.g.mkdp_auto_close = 0
                vim.keymap.set(
                    'n',
                    '<Leader>mp',
                    '<Plug>MarkdownPreviewToggle',
                    { desc = 'Preview markdown' }
                )
            end
        },

        -- Latex
        --  {
        --   'lervag/vimtex',
        --   disable = true,
        --   ft = 'tex',
        --   setup = conf('vimtex')
        -- }

        -- Comment
        {
            'numToStr/Comment.nvim',
            event = 'VimEnter',
            opts = {
                mappings = {
                    extra = false
                }
            },
        },

        -- Surround
        {
            "kylechui/nvim-surround",
            tag = '*',
            event = 'VimEnter',
            config = true
        },

        -- Align
        { 'junegunn/vim-easy-align', cmd = 'EasyAlign' },

        -- Indent line
        {
            'lukas-reineke/indent-blankline.nvim',
            cmd = 'IndentBlanklineToggle',
            dependencies = { 'sainnhe/gruvbox-material' },
            config = conf('indent-blankline')
        },

        -- Auto switch input method
        {
            'lyokha/vim-xkbswitch',
            event = 'VimEnter',
            enabled = function()
                return vim.g.sys_uname == 'win'
            end,
            init = function()
                vim.g.XkbSwitchEnabled = 1
                vim.g.XkbSwitchLib = vim.g.vimrc_home .. '/libxkbswitch64.dll'
            end
        },
        {
            'rlue/vim-barbaric',
            event = 'VimEnter',
            enabled = function()
                return vim.g.sys_uname ~= 'win'
            end
        },

        -- Textobjects
        -- {
        --     'kana/vim-textobj-indent',
        --     event = 'VimEnter',
        --     dependencies = { 'kana/vim-textobj-user' }
        -- },
        -- {
        --     'sgur/vim-textobj-parameter',
        --     event = 'VimEnter',
        --     dependencies = { 'kana/vim-textobj-user' },
        --     init = function()
        --         vim.g.vim_textobj_parameter_mapping = 'a'
        --     end
        -- },
        -- {
        --     'rbonvall/vim-textobj-latex',
        --     dependencies = { 'kana/vim-textobj-user' },
        --     ft = 'tex'
        -- },
    },
    -- configuration
    {
        defaults = {
            lazy = true,
        },
        git = {
            url_format = vim.g.repo_url .. "/%s.git",
        },
    })
