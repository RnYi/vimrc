-- Auto download packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', GitRepoUrl..'/wbthomason/packer.nvim', install_path})
  end
-- Manage plugins
require('packer').startup({
  -- add plugins
  function(use)
    -- load config
    local function conf(name)
      return ([[require('nvim.plugins.config.%s').setup()]]):format(name)
    end
    -- impatient.nvim
    use {
      'lewis6991/impatient.nvim',
      config = [[require('impatient')]],
    }
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim'}

    -- Faster filetype
    use { 'nathom/filetype.nvim' }

    -- UI hooks
    use {
      'stevearc/dressing.nvim',
      event = 'VimEnter',
      config = function ()
        require('dressing').setup({
        input = {
          -- window transparency
          winblend = 0,
        }
      })
      end
    }

    -- Treesitter
    use {
      { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'VimEnter' },
      {
        'nvim-treesitter/nvim-treesitter',
        event = 'VimEnter',
        run = ':TSUpdate',
        config = conf('treesitter')
      },
    }

    -- Icon
    use { 'kyazdani42/nvim-web-devicons' }

    -- Colorscheme
    use{
      'sainnhe/gruvbox-material',
      event = 'VimEnter',
      config = function ()
        vim.g.gruvbox_material_better_performance=1
        vim.g.gruvbox_material_enable_bold = 0
        vim.g.gruvbox_material_enable_italic=0
        vim.g.gruvbox_material_visual = 'blue background'
        vim.g.gruvbox_material_menu_selection_background='blue'
        vim.g.gruvbox_material_disable_italic_comment=1
        vim.g.gruvbox_material_sign_column_background='none'
        vim.g.gruvbox_material_transparent_background = 0
        vim.g.gruvbox_material_diagnostic_virtual_text='colored'
        vim.cmd('colorscheme gruvbox-material')
      end
    }

    -- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = conf('lualine')
    }

    -- Quickfix
    use {
      'kevinhwang91/nvim-bqf',
      -- ft = 'qf',
      event = 'VimEnter',
      config = function ()
        require('bqf').setup({
          preview = {
            auto_preview = false,
          },
          func_map = {
            tabc = '',
            tabdrop = '<C-t>',
            pscrollup = '<C-u>',
            pscrolldown = '<C-d>',
            split = '<C-t>'
          }
        })
      end
    }

    -- File Explorer
    use {
      'kyazdani42/nvim-tree.lua',
      cmd = 'NvimTreeToggle',
      config = conf('nvim-tree')
    }

    -- Searh and Move
    use {
      'phaazon/hop.nvim',
      cmd = {'HopWord', 'HopPattern', 'HopChar1', 'HopChar2', 'HopLine'},
      config = conf('hop')
    }

    -- Git
    use {
      'tpope/vim-fugitive',
      fn = 'fugitive#*',
      cmd = {'G', 'Git', 'Gedit', 'Gread', 'Gwrite', 'Gdiffsplit',  'Gvdiffsplit'},
      setup = conf('fugitive')
    }

    -- Telescope
    -- install rg and fd to improve performance:
    --     rg -> https://github.com/BurntSushi/ripgrep/releases
    --     fd -> https://github.com/sharkdp/fd/releases
    use {
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      requires = 'nvim-lua/plenary.nvim' ,
      config = conf('telescope')
    }
    -- Telescope extensions
    -- Telescope-fzf-native
    if OSName == 'win' then
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

    -- Session manager
    use {
      'Shatur/neovim-session-manager',
      event = 'VimEnter',
      requires = 'nvim-lua/plenary.nvim' ,
      config = function ()
        -- keymap
        local map = vim.keymap.set
        local map_opt = {noremap = true, silent = true}
        map('n', '<Leader>sl', '<Cmd>SessionManager load_session<CR>', map_opt)
        map('n', '<Leader>ss', '<Cmd>SessionManager save_current_session<CR>', map_opt)
        map('n', '<Leader>sd', '<Cmd>SessionManager delete_session<CR>', map_opt)
        -- config
        require('session_manager').setup({
          autosave_only_in_session = true,
        })
      end
    }

    -- Snippet
    use { "honza/vim-snippets", event = 'VimEnter'}
    use {
      'SirVer/ultisnips',
      event = 'VimEnter',
      setup = function ()
        vim.g.UltiSnipsExpandTrigger='<C-j>'
        vim.g.UltiSnipsJumpForwardTrigger='<C-j>'
        vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'
      end
    }
    -- use {
    --   'dcampos/nvim-snippy',
    --   event = 'VimEnter',
    --   config = function ()
    --     local dirs = {vim.fn.stdpath('data')..'/site/pack/packer/opt/vim-snippets/snippets',
    --   NvimHome..'/snippets'}
    --     require('snippy').setup({
    --       snippet_dirs = dirs,
    --       mappings = {
    --         is = {
    --           ['<C-j>'] = 'expand_or_advance',
    --           ['<C-k>'] = 'previous',
    --         },
    --       },
    --     })
    --   end
    -- }

    -- Handle delimiters
    use {
      'Raimondi/delimitMate',
      event = 'VimEnter',
      setup = function ()
        vim.g.delimitMate_expand_cr = 1
      end
    }

    -- Auto-completion for cmdline
    use { 'gelguy/wilder.nvim',
          disable = true,
          event='CmdlineEnter',
          run = ':UpdateRemotePlugins',
          config = conf('wilder')
    }

    -- Completion
    if CompPlug==nil or CompPlug=='nvim-cmp' then
      -- nvim-cmp
      use { 'onsails/lspkind-nvim', event = 'VimEnter' }
      use {
        'hrsh7th/nvim-cmp',
        after = 'lspkind-nvim',
        config = conf('nvim-cmp')
      }
      -- completion sources
      use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-nvim-lua', ft='lua'}
      use {'hrsh7th/cmp-omni', ft='tex'}
      use {
            'quangnguyen30192/cmp-nvim-ultisnips',
            after = {'nvim-cmp', 'ultisnips'}
          }
      -- use {
      --   'dcampos/cmp-snippy',
      --   after = {'nvim-cmp', 'nvim-snippy'}
      -- }

      -- nvim-lspconfig
      use {
        'neovim/nvim-lspconfig',
        after = 'cmp-nvim-lsp',
        config = conf('lsp')
      }
    else
      -- coc.nvim
      use {
        'neoclide/coc.nvim',
        branch='release',
        event = 'VimEnter',
        setup = conf('coc')
      }
    end

    -- Tag
    -- install gtags:
    --  -> http://adoxa.altervista.org/global/  (Windows)
    -- install ctags:
    --  -> https://github.com/universal-ctags/ctags-win32/releases  (Windows)
    -- use {
    --   'ludovicchabant/vim-gutentags',
    --   event = 'VimEnter',
    --   setup = require('nvim.plugins.config.gutentags').setup
    -- }
    -- use {
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
    --     vim.g.gutentags_plus_switch = 1
    --   end
    -- }

    -- Symbol
    -- use {
    --   'liuchengxu/vista.vim',
    --   cmd = 'Vista',
    --   setup = conf('vista')
    -- }

    -- Tasks
    use { 'skywind3000/asyncrun.vim', event = 'VimEnter' }
    use {
      'skywind3000/asynctasks.vim',
      after = 'asyncrun.vim',
      setup = conf('asynctasks')
    }

    -- Markdown
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = 'markdown',
      setup = function()
        vim.g.mkdp_auto_close=0
        vim.keymap.set(
        'n',
        '<Leader>mp',
        '<Plug>MarkdownPreviewToggle',
        {noremap=false}
        )
      end
    }

    -- Latex
    use {
      'lervag/vimtex',
      ft = 'tex',
      setup = conf('vimtex')
    }

    -- Comment
    use { 'tpope/vim-commentary', event = 'VimEnter' }

    -- Surround
    use { 'tpope/vim-repeat', event = 'VimEnter' }
    use { 'tpope/vim-surround', event = 'VimEnter' }

    -- Indent line
    use {
      'lukas-reineke/indent-blankline.nvim',
      event='VimEnter',
      config = conf('indent-blankline')
    }

    -- Auto switch input method
    if OSName == 'win' then
      use {
        'lyokha/vim-xkbswitch',
        event = 'VimEnter',
        setup = function ()
          vim.g.XkbSwitchEnabled=1
          vim.g.XkbSwitchLib=NvimHome..'/libxkbswitch64.dll'
        end
      }
    else
      use {
        'rlue/vim-barbaric',
        event = 'VimEnter'
      }
    end

    -- Auto set up configuration after cloning packer.nvim
    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  -- Configure packer
  config={
    max_jobs = 8,
    compile_path=vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
    git={
      -- github mirror
      default_url_format=GitRepoUrl..'/%s'
    }
  }
})

-- auto-generate packer_compiled.lua
vim.cmd[[
let g:packer_init = g:vimrc_home.'/lua/nvim/plugins/init.lua'
augroup AutoPackerCompile
autocmd!
autocmd BufWritePost */lua/nvim/plugins/* exe "so ".g:packer_init| PackerCompile
augroup END
]]

-- keymaps for packer.nvim
local map = vim.keymap.set
local map_opt = {noremap = true, silent = true}
map('n', '<Leader>pc', '<Cmd>PackerCompile<CR>', map_opt)
map('n', '<Leader>ps', '<Cmd>PackerSync<CR>', map_opt)
map('n', '<Leader>pt', '<Cmd>PackerStatus<CR>', map_opt)
map('n', '<Leader>pi', '<Cmd>PackerInstall<CR>', map_opt)
map('n', '<Leader>pu', '<Cmd>PackerUpdate<CR>', map_opt)

-- impatient.nvim requires to load packer_compiled manually
local status, _ = pcall(require, 'packer_compiled')
if not status then
  vim.notify('Failed to require packer_compiled.lua!', 'error', nil)
end
