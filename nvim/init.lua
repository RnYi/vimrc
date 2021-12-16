----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local fn=vim.fn
local opt=vim.opt
---------------
--  Prepare  --
---------------
-- define NvimHome
NvimHome=g.vimrc_home

require('config')
require('keymaps')
