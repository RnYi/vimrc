-------------
--  Basic  --
-------------
vim.opt.mouse='a'
vim.opt.autoread=true
vim.opt.winaltkeys=false
vim.opt.backspace={'indent','eol','start'}
vim.opt.pastetoggle=vim.api.nvim_replace_termcodes('<M-p>', true, true, true)
vim.opt.ttimeout=100
vim.opt.ttimeoutlen=100
vim.opt.updatetime=300
vim.opt.undofile=true
vim.g.tex_flavor='latex'
vim.g.mapleader=' '
vim.g.maplocalleader=' '
local undo_dir=vimrc_home..'/undofiles/nvim'
