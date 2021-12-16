----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local fn=vim.fn
local opt=vim.opt
local cmd=vim.cmd

-------------
--  Basic  --
-------------
opt.mouse='a'
opt.autoread=true
opt.winaltkeys=false
opt.backspace={'indent','eol','start'}
opt.ttimeout=100
opt.ttimeoutlen=100
opt.updatetime=300
opt.foldmethod='manual'
-- enable undofile and set undodir
opt.undofile=true
local nvim_undo_dir=NvimHome..'/undofiles/nvim'
if fn.isdirectory(nvim_undo_dir)==0 then
    fn.mkdir(nvim_undo_dir,'p')
end
opt.undodir=nvim_undo_dir
-- search path of tags file
opt.tags={'./.tags;','.tags'}
-- specify tex filetype
g.tex_flavor='latex'
-- language support
g.loaded_perl_provider=0
g.loaded_ruby_provider=0
g.loaded_python_provider=0
g.python3_host_prog='python'

--------------
--  Indent  --
--------------
opt.tabstop=4
opt.shiftwidth=4
opt.softtabstop=4
opt.expandtab=true
opt.autoindent=true
opt.smartindent=true
opt.shiftround=true

----------------
--  Encoding  --
----------------
opt.encoding='utf-8'
opt.termencoding='utf-8'
opt.fileencoding='utf-8'
opt.fileencodings={'utf-8','usc-bom','chinese','gb18030','gbk','gb2312','cp936'}

---------------
--  Display  --
---------------
opt.wrap=true
opt.number=true
opt.signcolumn='number'
opt.title=true
opt.titlestring='%{getcwd()}'
opt.hidden=true
opt.wildmenu=true
opt.showmode=true
opt.showmatch=true
opt.matchtime=1
opt.cursorline=true
opt.showbreak='↪'
opt.scrolloff=5
opt.sidescrolloff=5
opt.laststatus=2
opt.shortmess:append('c')
opt.shortmess:remove('S')
opt.termguicolors=true
opt.formatoptions:append({'m','M','j'})
opt.list=true
opt.listchars={trail='·',extends='⟩',precedes='⟨'}

--------------
--  Search  --
--------------
opt.wrapscan=true
opt.smartcase=true
opt.hlsearch=false
opt.incsearch=true
opt.ignorecase=true
opt.inccommand=true

---------------
--  Session  --
---------------
opt.viewoptions:remove('options')
opt.sessionoptions:remove('blank')
opt.sessionoptions:remove('help')
opt.sessionoptions:remove('options')
opt.sessionoptions:remove('winpos')
opt.sessionoptions:remove('terminal')

---------------
--  Autocmd  --
---------------
cmd([[
augroup MyAug
    autocmd!
    autocmd BufReadPost *
                \   if line("'\"") > 0 && line ("'\"") <= line("$") |
                \       exe "normal g'\"" |
                \   endif
    " autocmd BufRead txt if &buftype=='help' | wincmd L | endif
    " autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType markdown hi! ErrorMsg NONE
    autocmd BufNewFile,BufRead *.tlc setlocal filetype=tlc
    autocmd TermOpen * startinsert
    autocmd TermEnter * setlocal nonumber
    autocmd TermLeave * setlocal number
augroup END
]])
