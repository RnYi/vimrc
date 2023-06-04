"""""""""""
"  Basic  "
"""""""""""
set mouse=nvi
set autoread
set winaltkeys=no
set mousemodel=extend
set backspace=indent,eol,start
if !exists('g:syntax_on')
  syntax enable
endif
let g:tex_flavor='latex'
set ttimeout ttimeoutlen=100
set updatetime=300
" undo
set undofile
let s:undo_dir=g:vimrc_home.'/undo'
call mkdir(s:undo_dir,'p')
let &undodir=s:undo_dir
" view
let s:view_dir=g:vimrc_home.'/view'
call mkdir(s:view_dir,'p')
let &viewdir=s:view_dir
set tags=./.tags;,.tags
set diffopt+=vertical,followwrap
set grepprg=rg\ --vimgrep

""""""""""""
"  Indent  "
""""""""""""
set expandtab
" set tabstop=4
set shiftwidth=2
set softtabstop=-1
set shiftround
set autoindent smartindent

""""""""""""""
"  Encoding  "
""""""""""""""
" language en_US
" set ambiwidth=double
set langmenu=en_US
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gb18030,gbk,gb2312,cp936
if has('gui_running')
  if g:sys_uname=='win'
    set guifont=FiraCode\ Nerd\ Font\ Mono:h14
    " set guifont=*
    set guifontwide=黑体:h14
  elseif g:sys_uname=='unix'
    set guifont=MesloLGS\ Nerd\ Font\ 14
  endif
endif

"""""""""""""
"  Display  "
"""""""""""""
set number
set signcolumn=number
set wrap
set title titlestring=%{getcwd()}
set hidden
set wildmenu
set noshowcmd
set showmode
set showmatch matchtime=1
" set showbreak=↪
set cursorline
set scrolloff=2 sidescrolloff=5
set laststatus=2
set shortmess+=c shortmess-=S
set guioptions=crh
set termguicolors
set display+=lastline
set formatoptions-=o
set formatoptions+=mMj
set list listchars=trail:·,extends:⟩,precedes:⟨
set guicursor+=a:blinkon0
let &t_EI .= "\<Esc>[1 q"
let &t_SI .= "\<Esc>[5 q"
" if &term =~ '^xterm'
"   let &t_SI .= "\<Esc>[5 q"
" 1 or 0 -> blinking block
" 3 -> blinking underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
" endif

""""""""""""""""
"  Statusline  "
""""""""""""""""
" if !has_key(g:plugs_enabled,'lightline.vim')
if 0
  function! StlFilePath()
    let l:rlpath=expand('%')
    let l:fern_path_pat='\Vfern://\.\+/file:///\zs\.\+\ze;keep$\$'
    return &filetype ==? 'fern' ? '[Fern]'.'['.matchstr(expand('%:p'),l:fern_path_pat).']':
          \          &filetype ==? 'startify' ? '[Startify]' :
          \          &buftype ==? 'quickfix' ? '':
          \          &buftype ==? 'terminal' ? '' :
          \          &buftype ==? 'help' ? expand('%:t') :
          \          l:rlpath==?''?"[No Name]": l:rlpath
  endfunction

  function! StlFiletype()
    return &filetype ==? 'fern' ? '' :
          \          &filetype ==? 'startify' ? '' :
          \          &filetype ==? 'vim-plug' ? '':
          \          &buftype ==? 'quickfix' ? '':
          \          &buftype ==? 'help' ? '':
          \          &buftype ==? 'terminal' ? '':
          \          &filetype ==? ''?"[noft]": &filetype
  endfunction

  function! StlFormat()
    return &filetype ==? 'fern' ? '' :
          \          &filetype ==? 'startify' ? '' :
          \          &filetype ==? 'vim-plug' ? '':
          \          &buftype ==? 'quickfix' ? '':
          \          &buftype ==? 'help' ? '':
          \          &buftype ==? 'terminal' ? '':
          \          &fileencoding?&fileencoding.'['.&fileformat.']':
          \          &encoding.'['.&fileformat.']'
  endfunction

  set statusline=
  set statusline+=\ 
  set statusline+=%q " [Quickfix List]
  set statusline+=%{StlFilePath()}
  set statusline+=\ 
  set statusline+=%{&modified?'[+]':''}
  set statusline+=%h " [help]
  set statusline+=%r " [R0]
  set statusline+=%{&paste?'[paste]':''}
  if has_key(g:plugs_enabled,'coc.nvim')
    set statusline+=\ 
    set statusline+=%{exists('g:did_coc_loaded')?coc#status():''}
  endif
  if has_key(g:plugs_enabled,'vim-gutentags')
    set statusline+=\ 
    set statusline+=%{exists('g:loaded_gutentags')?gutentags#statusline('[',']'):''}
  endif
  set statusline+=%=
  set statusline+=%{StlFormat()}\ \|
  set statusline+=\ 
  set statusline+=%{StlFiletype()}\ \|
  set statusline+=\ 
  set statusline+=%l/%L\ 
  set statusline+=\(%p%%\)
  set statusline+=\ 
endif

"""""""""""""
"  Tabline  "
"""""""""""""
" Tabline in terminal mode
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

" get a single tab name
function! NeatBuffer(bufnr, fullname)
  let l:name = bufname(a:bufnr)
  let bt = getbufvar(a:bufnr, '&buftype')
  if getbufvar(a:bufnr, '&modifiable')
    if l:name == ''
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

" get a single tab label
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

" set tabline
set showtabline=2
if !has_key(g:plugs_enabled,'lightline.vim')
  set tabline=%!NeatTabLine()
endif

"""""""""""
"  Theme  "
"""""""""""
if has_key(g:plugs_enabled, 'gruvbox-material')
  let g:gruvbox_material_better_performance=1
  let g:gruvbox_material_enable_bold=0
  let g:gruvbox_material_enable_italic=1
  let g:gruvbox_material_disable_italic_comment=1
  let g:gruvbox_material_sign_column_background='none'
  colorscheme gruvbox-material
  hi clear CursorLine
end

""""""""""""
"  Search  "
""""""""""""
set wrapscan
set smartcase
set incsearch
set ignorecase

"""""""""""""
"  Session  "
"""""""""""""
set viewoptions-=options
set sessionoptions-=blank
set sessionoptions-=options
set sessionoptions-=winpos
set sessionoptions-=terminal
set sessionoptions-=help

""""""""""
"  Fold  "
""""""""""
set foldmethod=manual

"""""""""""""
"  Autocmd  "
"""""""""""""
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

augroup MyAug
  autocmd!
  autocmd BufReadPost * call s:resume_cursor_position()
autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType markdown hi! Error NONE
autocmd BufNewFile,BufRead *.tlc setlocal filetype=tlc
autocmd CmdlineEnter /,\? :set hlsearch
autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
