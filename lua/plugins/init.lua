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

    -- Treesitter
    use {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        -- event='BufEnter',
      },
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require('plugins/config/treesitter').setup
      },
    }

    -- Colorscheme
    use {
      'rmehri01/onenord.nvim',
      config = function ()
        require('onenord').setup({
          styles = {
            diagnostics = 'undercurl',
          },
        })
        vim.cmd('colorscheme onenord')
      end
    }

    -- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = require('plugins/config/lualine').setup
    }

    -- Tabline
    use {
      'romgrk/barbar.nvim',
      requires = {'kyazdani42/nvim-web-devicons'},
      event = 'BufEnter',
      setup = require('plugins/config/barbar').setup
    }

    -- File Explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
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
      setup = require('plugins/config/fugitive').setup,
    }

    -- Telescope
    -- install rg and fd to improve performance:
    --     rg -> https://github.com/BurntSushi/ripgrep/releases
    --     fd -> https://github.com/sharkdp/fd/releases
    use {
      'nvim-telescope/telescope.nvim',
      event = 'BufEnter',
      requires = 'nvim-lua/plenary.nvim',
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
      config = [[require('telescope').load_extension('sessions')]]
    }

    -- Snippet
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
        'onsails/lspkind-nvim',
        event = 'BufEnter',
      },
      {
        'hrsh7th/nvim-cmp',
        after = 'lspkind-nvim',
        event = 'BufEnter',
        config = require('plugins/config/nvim-cmp').setup
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
      config = require('plugins/config/lsp').setup
    }

    -- Tasks
    use {
      'skywind3000/asynctasks.vim',
      event = 'BufEnter',
      requires = 'skywind3000/asyncrun.vim',
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

    -- Comment
    use {
      'numToStr/Comment.nvim',
      event = 'BufEnter',
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
      'tpope/vim-surround',
      requires = 'tpope/vim-repeat',
      event = 'BufEnter',
    }


    -- Indent line
    use {
      'lukas-reineke/indent-blankline.nvim',
      cmd = 'IndentBlanklineToggle',
      config = require('plugins/config/indent-blankline').setup
    }

    -- Auto switch input method
    if OSName == 'win' then
      use {
        'lyokha/vim-xkbswitch',
        event = 'BufEnter',
        setup = function ()
          vim.g.XkbSwitchEnabled=1
          vim.g.XkbSwitchLib=NvimHome..'/libxkbswitch64.dll'
        end
      }
    else
      use {
        'rlue/vim-barbaric',
        event = 'BufEnter'
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
    profile = {enable=true},
    git={
      -- use fastgit for git clone
      default_url_format=GitRepoUrl..'/%s'
    }
  }
})

-- impatient.nvim requires to load packer_compiled manually
local status, _ = pcall(require, 'packer_compiled')
if not status then
  vim.notify('Failed to require packer_compiled.lua!', 'error', nil)
end
