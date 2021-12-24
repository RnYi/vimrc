---------------
--  Prepare  --
---------------
NvimHome=vim.g.vimrc_home   -- define NvimHome
GitRepoUrl=vim.g.repo_url
OSName=vim.g.sys_uname
--------------
--  Others  --
--------------
require('config')
require('keymaps')
require('plugins')
