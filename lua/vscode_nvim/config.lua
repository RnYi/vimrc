----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local opt=vim.opt

-------------
--  Basic  --
-------------
opt.mouse='nv'
opt.mousemodel='extend'
opt.backup=false
opt.writebackup=false
opt.autoread=true
opt.winaltkeys='no'
opt.backspace={'indent','eol','start'}
-- opt.ttimeout=true
-- opt.ttimeoutlen=100
-- opt.updatetime=300
opt.foldmethod='manual'
-- opt.switchbuf = {'usetab','newtab'}
-- Persistent undo
-- Search path of tags file
opt.tags={'./.tags;','.tags'}
-- Diff
opt.diffopt:append('vertical')
-- Grepper
opt.grepprg = 'rg --vimgrep'
-- Specify tex filetype
g.tex_flavor='latex'
-- Language support
g.loaded_perl_provider=0
g.loaded_ruby_provider=0
g.loaded_python_provider=0
g.python3_host_prog='python3'
-- disable internal plugins
g.loaded_netrw = 1
g.loaded_netrwPlugin=1

--------------
--  Indent  --
--------------
-- opt.tabstop=4
opt.shiftwidth=4
opt.softtabstop=-1
opt.expandtab=true
opt.autoindent=true
opt.smartindent=true
opt.shiftround=true

----------------
--  Encoding  --
----------------
opt.encoding='utf-8'
opt.fileencoding='utf-8'
opt.fileencodings={'utf-8','usc-bom','chinese','gb18030','gbk','gb2312','cp936'}

---------------
--  Display  --
---------------
opt.wrap=true
opt.number=true
opt.showcmd=false
opt.pumheight=20
opt.signcolumn='yes'
-- opt.title=true
-- opt.titlestring='%{getcwd()}'
opt.hidden=true
opt.wildmenu=true
opt.showmode=true
opt.cursorline=false
opt.scrolloff=5
opt.sidescrolloff=5
opt.laststatus=2
opt.termguicolors=true
opt.shortmess={a=true,o=true,O=true,c=true,t=true,T=true,F=true}
opt.formatoptions={t=true,c=true,r=true,q=true,l=true,m=true,M=true,j=true}
opt.list=true
-- opt.showbreak='↪'
-- opt.listchars={trail='·',extends='⟩',precedes='⟨'}
-- vim.cmd([[
-- set matchpairs+=「:」,『:』,【:】,“:”,‘:’,《:》,（:）
-- ]])

-----------
-- Seach --
-----------
opt.wrapscan=true
opt.smartcase=true
opt.incsearch=true
opt.ignorecase=true

---------------
--  Session  --
---------------
opt.viewoptions:remove('options')
opt.sessionoptions:remove('blank')
opt.sessionoptions:remove('winpos')
opt.sessionoptions:remove('terminal')
opt.sessionoptions:remove('options')
opt.sessionoptions:remove('help')
