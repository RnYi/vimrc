local map = vim.keymap.set
local map_opt = {noremap=true, silent=true}
require('packer').startup({
  -- add plugins
  function(use)
    -- impatient.nvim
    use {
      'lewis6991/impatient.nvim',
      config = [[require('impatient')]],
    }
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim'}
    -- Faster filetype
    use { 'nathom/filetype.nvim'}
    -- Comment
    use {
        'numToStr/Comment.nvim',
        event = 'VimEnter',
        config = function()
            require('Comment').setup{
                mappings = {
                    extra = false
                }
            }
        end
    }
    -- Surround
    use {
        "kylechui/nvim-surround",
        tag = '*',
        event = 'VimEnter',
        config = function()
            require('nvim-surround').setup{ }
        end
    }
    -- Align
    use { 'junegunn/vim-easy-align', cmd = 'EasyAlign' }
    -- Textobjects
   use { 'kana/vim-textobj-user', event = 'VimEnter' }
   use { 'kana/vim-textobj-indent', after = 'vim-textobj-user' }
   use {
     'sgur/vim-textobj-parameter',
     after = 'vim-textobj-user',
     setup = function()
       vim.cmd[[
       let g:vim_textobj_parameter_mapping = 'a'
       ]]
     end
   }
   use {
     'rbonvall/vim-textobj-latex',
     after = 'vim-textobj-user',
     ft = 'tex'
   }
  end,

  -- Configure packer
  config={
    max_jobs = 8,
    compile_path=vim.fn.stdpath('config')..'/lua/packer_compiled_for_vscode.lua',
    git={
      -- github mirror
      default_url_format=GitRepoUrl..'/%s'
    }
  }
})

-- auto-generate packer_compiled.lua
vim.cmd[[
let g:packer_init = g:vimrc_home.'/lua/vscode_nvim/plugins.lua'
augroup AutoPackerCompile
autocmd!
autocmd BufWritePost */lua/vscode_nvim/plugins.lua exe "so ".g:packer_init| PackerCompile
autocmd User PackerCompileDone lua vim.notify('PackerCompile Done!', 'info', nil)
augroup END
]]

-- impatient.nvim requires to load packer_compiled manually
local status, _ = pcall(require, 'packer_compiled_for_vscode')
if not status then
  vim.notify('Failed to require packer_compiled.lua!', vim.log.levels.ERROR, nil)
end
