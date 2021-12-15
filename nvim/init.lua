----------------------------
--  Aliases for Nvim API  --
----------------------------
local fn=vim.fn

---------------
--  prepare  --
---------------
if vimrc_home==nil then
    vimrc_home=fn.fnamemodify(fn.resolve(fn.expand('<sfile>:p')),':h')
end

require('config')
require('keymaps')
