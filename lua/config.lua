----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local opt=vim.opt

-------------
--  Basic  --
-------------
opt.mouse='nv'
opt.autoread=true
opt.winaltkeys='no'
opt.backspace={'indent','eol','start'}
opt.ttimeout=true
opt.ttimeoutlen=100
opt.updatetime=300
opt.foldmethod='manual'
opt.switchbuf = {'usetab','newtab'}
-- Persistent undo
opt.undofile=true
-- Search path of tags file
opt.tags={'./.tags;','.tags'}
-- Font
opt.guifont = 'FiraCode NF:h14'
opt.guifontwide = '黑体:h14'
opt.lazyredraw=true
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
g.python3_host_prog='python'
-- disable internal plugins
g.loaded_netrwPlugin=1

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
opt.wrap=true
opt.number=true
opt.showcmd=false
opt.pumheight=20
opt.signcolumn='yes:1'
opt.title=true
opt.titlestring='%{getcwd()}'
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
opt.listchars={trail='·',extends='⟩',precedes='⟨'}
vim.cmd([[
set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》
]])

---------------
--  Tabline  --
---------------
-- Tabline in terminal mode
vim.cmd [[
function! NeatTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
  " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by NeatTabLabel()
    let s .= ' %{NeatTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  return s
endfunction
]]

-- get a single tab name
vim.cmd[[
function! NeatBuffer(bufnr, fullname)
  let l:name = bufname(a:bufnr)
  let bt = getbufvar(a:bufnr, '&buftype')
  if getbufvar(a:bufnr, '&modifiable')
    if bt=='prompt'
      return '[Prompt]'
    elseif l:name == ''
      return '[No Name]'
    elseif bt == 'terminal'
      return '[Terminal]'
    else
      if a:fullname 
        return fnamemodify(l:name, ':p')
      else
        let aname = fnamemodify(l:name, ':p')
        let sname = fnamemodify(aname, ':t')
        if sname == ''
          let test = fnamemodify(aname, ':h:t')
          if test != ''
            return '<'. test . '>'
          endif
        endif
        return sname
      endif
    endif
  else
    let bt = getbufvar(a:bufnr, '&buftype')
    if bt == 'quickfix'
      return '[Quickfix]'
    elseif bt == 'terminal'
      return '[Terminal]'
    elseif l:name != ''
      if a:fullname 
        return '-'.fnamemodify(l:name, ':p')
      else
        return '-'.fnamemodify(l:name, ':t')
      endif
    else
    endif
    return '[No Name]'
  endif
endfunc
]]

-- get a single tab label
vim.cmd[[
function! NeatTabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  let l:bufnr = l:buflist[l:winnr - 1]
  let l:fname = NeatBuffer(l:bufnr, 0)
  let l:buftype = getbufvar(l:bufnr, '&buftype')
  let l:num = a:n
  if getbufvar(l:bufnr, '&modified')
    return "(".l:num.") ".l:fname." +"
  endif
  return "(".l:num.") ".l:fname
endfunc
]]

-- set tabline
vim.cmd[[
set showtabline=2
set tabline=%!NeatTabLine()
]]

--------------
--  Search  --
--------------
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

---------------
--  Autocmd  --
---------------
vim.cmd[[
function s:resume_cursor_position() abort
  if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    let l:args = v:argv  " command line arguments
    for l:cur_arg in l:args
      " Check if a go-to-line command is given.
      let idx = match(l:cur_arg, '\v^\+(\d){1,}$')
      if idx != -1
        return
      endif
    endfor

    execute "normal! g`\"zvzz"
  endif
endfunction

augroup rany_aug
  autocmd!
  " resume cursor position when open a file
  autocmd BufReadPost * call s:resume_cursor_position()
  " disable error highlighting
  autocmd FileType markdown hi! Error NONE
  " tlc
  autocmd BufNewFile,BufRead *.tlc setlocal filetype=tlc
  " .gitignore
  autocmd BufNewFile,BufRead .gitignore setlocal filetype=gitignore
  " terminal
  autocmd TermOpen * startinsert
  autocmd TermEnter * setlocal nonumber
  autocmd TermLeave * setlocal number
  " highlight when searching
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]]
