---------------
--  Prepare  --
---------------
NvimHome=vim.g.vimrc_home
GitRepoUrl=vim.g.repo_url
OSName=vim.g.sys_uname
CompPlug=vim.g.comp_plug
--------------------------
--  Load config files  --
--------------------------
require('rany_nvim.config')
require('rany_nvim.keymaps')
require('rany_nvim.plugins')
