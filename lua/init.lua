----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g

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
