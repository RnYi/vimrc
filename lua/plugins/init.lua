-- Manage plugins
require('packer').startup({
  -- add plugins
  function(use)
    -- impatient.nvim
    use {
      'lewis6991/impatient.nvim',
      config = [[require('impatient')]],
    }
    -- Packer can manage itself
    use {
      'wbthomason/packer.nvim',
    }

    -- Faster filetype
    use {
      'nathom/filetype.nvim'
    }

    -- UI hooks
    use {
      'stevearc/dressing.nvim',
      event = 'VimEnter',
    }

    -- Treesitter
    use {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'VimEnter',
      },
      {
        'nvim-treesitter/nvim-treesitter',
        event = 'VimEnter',
        run = ':TSUpdate',
        config = require('plugins/config/treesitter').setup
      },
    }

    -- Icon
    use {
      'kyazdani42/nvim-web-devicons'
    }

    -- Colorscheme
    use{
      'sainnhe/gruvbox-material',
      event = 'VimEnter',
      config = function ()
        vim.g.gruvbox_material_better_performance=1
        vim.g.gruvbox_material_sign_column_background='none'
        vim.cmd('colorscheme gruvbox-material')
      end
    }

    -- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = require('plugins/config/lualine').setup
    }

    -- File Explorer
    use {
      'kyazdani42/nvim-tree.lua',
      cmd = 'NvimTreeToggle',
      config = require('plugins/config/nvim-tree').setup
    }

    -- Searh and Move
    use {
      'phaazon/hop.nvim',
      cmd = {'HopWord', 'HopPattern', 'HopChar1', 'HopChar2', 'HopLine'},
      config = require('plugins/config/hop').setup
    }

    -- Git
    use {
      'tpope/vim-fugitive',
      fn = 'fugitive#*',
      cmd = {'G', 'Git', 'Gedit', 'Gread', 'Gwrite', 'Gdiffsplit',  'Gvdiffsplit'},
      setup = require('plugins/config/fugitive').setup,
    }

    -- Telescope
    -- install rg and fd to improve performance:
    --     rg -> https://github.com/BurntSushi/ripgrep/releases
    --     fd -> https://github.com/sharkdp/fd/releases
    use {
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      requires = 'nvim-lua/plenary.nvim' ,
      config = require('plugins/config/telescope').setup
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
      after = 'telescope.nvim',
      config = function ()
        require('session_manager').setup({
          -- autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
          autosave_only_in_session = true
        })
        require('telescope').load_extension('sessions')
      end
    }

    -- Snippet
    use {
      "SirVer/ultisnips",
      event = 'VimEnter',
      setup = function()
        vim.g.UltiSnipsExpandTrigger = '<C-j>'
        vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
        vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'
        vim.g.UltiSnipsListSnippets='<C-l>'
      end
    }
    use { "honza/vim-snippets", after = 'ultisnips'}

    if CompPlug==nil or CompPlug=='nvim-cmp' then
      -- nvim-cmp
      use {
        'onsails/lspkind-nvim',
        event = 'VimEnter',
      }
      use {
        'hrsh7th/nvim-cmp',
        after = 'lspkind-nvim',
        config = require('plugins/config/nvim-cmp').setup
      }
      -- completion sources
      use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'}
      use {'hrsh7th/cmp-nvim-lua', ft='lua'}
      use { 'hrsh7th/cmp-omni', ft='tex'}
      use {
        'quangnguyen30192/cmp-nvim-ultisnips',
        after = {'nvim-cmp', 'ultisnips'}
      }

      -- nvim-lspconfig
      use {
        'neovim/nvim-lspconfig',
        after = 'cmp-nvim-lsp',
        config = require('plugins/config/lsp').setup
      }
    else
      -- coc.nvim
      use {
        'neoclide/coc.nvim',
        branch='release',
        event = 'VimEnter',
        setup = require('plugins/config/coc').setup
      }
    end

    -- Tasks
    use       {
      'skywind3000/asyncrun.vim',
      event = 'VimEnter',
    }
    use {
      'skywind3000/asynctasks.vim',
      after = 'asyncrun.vim',
      setup = require('plugins/config/asynctasks').setup
    }

    -- Markdown
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = 'markdown',
      setup = function()
        vim.g.mkdp_auto_close=0
        vim.api.nvim_set_keymap(
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
      setup = require('plugins/config/vimtex').setup
    }

    -- Comment
    use {
      'numToStr/Comment.nvim',
      event = 'VimEnter',
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

    -- Surround
    use {
      'tpope/vim-repeat',
      event = 'VimEnter',
    }
    use {
      'tpope/vim-surround',
      event = 'VimEnter',
    }

    -- Indent line
    use {
      'lukas-reineke/indent-blankline.nvim',
      event='VimEnter',
      config = require('plugins/config/indent-blankline').setup
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
  end,

  -- Configure packer
  config={
    compile_path=vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    },
    git={
      -- github mirror
      default_url_format=GitRepoUrl..'/%s'
    }
  }
})

-- impatient.nvim requires to load packer_compiled manually
local status, _ = pcall(require, 'packer_compiled')
if not status then
  vim.notify('Failed to require packer_compiled.lua!', 'error', nil)
end
