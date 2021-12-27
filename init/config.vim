"""""""""""
"  Basic  "
"""""""""""
set mouse=a
set autoread
set winaltkeys=no
set mousemodel=extend
set backspace=indent,eol,start
if !exists('g:syntax_on')
  syntax enable
endif
let g:tex_flavor='tex'
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"
set pastetoggle=<M-p>
set ttimeout ttimeoutlen=100
set updatetime=300
set clipboard+=unnamed,unnamedplus
set undofile
set tags=./.tags;,.tags

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
    set guifont=Fira\ Code:h14
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
" set wrap
set title titlestring=%{getcwd()}
set hidden
set wildmenu
" set noshowcmd
set showmode
set showmatch matchtime=1
set cursorline
set showbreak=↪
set scrolloff=2 sidescrolloff=5
set laststatus=2
set shortmess+=c shortmess-=S
set guioptions=crh
set termguicolors
set display+=lastline
set formatoptions-=o
set formatoptions+=mMj
set list listchars=trail:·,extends:⟩,precedes:⟨
" set guicursor+=a:blinkon0
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

"""""""""""
"  Theme  "
"""""""""""
if has_key(g:plugs_enabled, 'nord-vim')
  colorscheme nord
end

""""""""""""
"  Search  "
""""""""""""
set wrapscan
set smartcase
set nohlsearch
set incsearch
set ignorecase

"""""""""""""
"  Session  "
"""""""""""""
set viewoptions-=options
set sessionoptions-=blank
set sessionoptions-=help
set sessionoptions-=options
" set sessionoptions-=tabpages
set sessionoptions-=winpos
set sessionoptions-=terminal

""""""""""
"  Fold  "
""""""""""
set foldmethod=manual

"""""""""""""
"  Autocmd  "
"""""""""""""
augroup MyAug
  autocmd!
  " autocmd BufReadPost *
  "       \   if line("'\"") > 0 && line ("'\"") <= line("$") |
  "       \       exe "normal g'\"" |
  "       \   endif
  " autocmd BufRead txt if &buftype=='help' | wincmd L | endif
  " autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType markdown hi! Error NONE
  autocmd BufNewFile,BufRead *.tlc setlocal filetype=tlc
augroup END
