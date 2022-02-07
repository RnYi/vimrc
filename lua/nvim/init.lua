---------------
--  Prepare  --
---------------
NvimHome=vim.g.vimrc_home   -- define NvimHome
GitRepoUrl=vim.g.repo_url
OSName=vim.g.sys_uname
CompPlug=vim.g.comp_plug
--------------
--  Others  --
--------------
require('nvim.config')
require('nvim.keymaps')
require('nvim.plugins')
