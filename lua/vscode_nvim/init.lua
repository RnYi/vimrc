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
require('vscode_nvim.config')
require('vscode_nvim.keymaps')
require('vscode_nvim.plugins')
