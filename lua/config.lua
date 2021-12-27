----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local opt=vim.opt
local cmd=vim.cmd

-------------
--  Basic  --
-------------
opt.mouse='a'
opt.autoread=true
opt.winaltkeys='no'
opt.backspace={'indent','eol','start'}
opt.ttimeout=true
opt.ttimeoutlen=100
opt.updatetime=200
opt.clipboard:append('unnamedplus')
opt.foldmethod='manual'
-- Persistent undo
opt.undofile=true
-- Search path of tags file
opt.tags={'./.tags;','.tags'}
-- Specify tex filetype
g.tex_flavor='latex'
-- Language support
g.loaded_perl_provider=0
g.loaded_ruby_provider=0
g.loaded_python_provider=0
g.python3_host_prog='python'
-- Font
opt.guifont = 'FiraCode NF:h14'
opt.guifontwide = '黑体:h14'

--------------
--  Indent  --
--------------
-- opt.tabstop=4
opt.shiftwidth=2
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
opt.wrap=false
opt.number=true
opt.signcolumn='number'
opt.title=true
opt.titlestring='%{getcwd()}'
opt.hidden=true
-- opt.lazyredraw=true
opt.wildmenu=true
opt.showmode=true
opt.showmatch=true
-- opt.matchtime=1
opt.cursorline=true
opt.scrolloff=5
opt.sidescrolloff=5
opt.laststatus=2
opt.shortmess:append('c')
opt.shortmess:remove('S')
opt.termguicolors=true
opt.formatoptions:remove('o')
opt.formatoptions:append('mMj')
opt.list=true
-- opt.showbreak='↪'
opt.listchars={trail='·',extends='⟩',precedes='⟨'}
cmd([[
set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》
]])

--------------
--  Search  --
--------------
opt.wrapscan=true
opt.smartcase=true
opt.hlsearch=false
opt.incsearch=true
opt.ignorecase=true

---------------
--  Session  --
---------------
opt.sessionoptions:remove('blank')
opt.sessionoptions:remove('help')
opt.sessionoptions:remove('winpos')
opt.sessionoptions:remove('terminal')

---------------
--  Autocmd  --
---------------
cmd([[
augroup rany_aug
autocmd!
autocmd FileType markdown hi! Error NONE
autocmd BufNewFile,BufRead *.tlc setlocal filetype=tlc
autocmd BufNewFile,BufRead .gitignore setlocal filetype=gitignore
autocmd TermOpen * startinsert
autocmd TermEnter * setlocal nonumber
autocmd TermLeave * setlocal number
autocmd CmdlineEnter /,\? :set hlsearch
autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]])
