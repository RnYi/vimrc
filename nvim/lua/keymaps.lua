----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local opt=vim.opt
local map=vim.api.nvim_set_keymap
local bmap=vim.api.nvim_buf_set_keymap
----------------
--  Internal  --
----------------
g.mapleader=' '
g.maplocalleader=' '
opt.pastetoggle=vim.api.nvim_replace_termcodes('<M-p>', true, true, true)

-----------------
--  Customize  --
-----------------
map('','H','^',{noremap=true})
map('','L','$',{noremap=true})

map('','<M-j>','gj',{noremap=true})
map('','<M-k>','gk',{noremap=true})

map('n','<M-J>','<C-w>j',{noremap=true})
map('n','<M-K>','<C-w>k',{noremap=true})
map('n','<M-H>','<C-w>h',{noremap=true})
map('n','<M-L>','<C-w>l',{noremap=true})
map('n','<M-Q>','<Cmd>close<CR>',{noremap=true})
