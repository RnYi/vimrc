----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local fn=vim.fn
local opt=vim.opt

---------------
--  Prepare  --
---------------
NvimHome=g.vimrc_home   -- define NvimHome

--------------
--  Others  --
--------------
require('config')
require('keymaps')
require('plugins')
