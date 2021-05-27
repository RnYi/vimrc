"""""""""""
"  Basic  "
"""""""""""
set mouse=nvi
set autoread
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
set undofile
if has('nvim')
    set undodir=~/undofiles/nvim
else
    set undodir=~/undofiles/vim
endif

""""""""""""
"  Indent  "
""""""""""""
set tabstop=4
set expandtab
set shiftround
set autoindent
set smartindent
set shiftwidth=4

"""""""""""""
"  Display  "
"""""""""""""
set wrap
set title
set hidden
set number
set wildmenu
set noshowcmd
set linebreak
set breakat-=_
set cursorline
set scrolloff=1
set laststatus=2
set shortmess+=c
set guioptions=cr
set termguicolors
set display+=lastline
set sidescrolloff=5
set formatoptions+=mMj
set titlestring=%{getcwd()}
set guicursor+=a:blinkon0
if &term =~ '^xterm'
  let &t_SI .= "\<Esc>[5 q"
  let &t_EI .= "\<Esc>[1 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

"""""""""""
"  Theme  "
"""""""""""
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 1
let g:sonokai_better_performance = 1
colorscheme sonokai
" let ayucolor="mirage"
" colorscheme ayu
" hi VertSplit guifg=black guibg=NONE

""""""""""""
"  Search  "
""""""""""""
set wrapscan
set smartcase
set nohlsearch
set incsearch
set ignorecase
if has('nvim')
    set inccommand=nosplit
endif

""""""""""""""
"  Encoding  "
""""""""""""""
" language en_US
set langmenu=en_US
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gb18030,gbk,gb2312,cp936
if has('gui_running')
    set guifont=MesloLGS\ NF:h14
    set guifontwide=等距更纱黑体\ SC:h14
endif

"""""""""""""
"  Session  "
"""""""""""""
set viewoptions-=options
set sessionoptions-=options
set sessionoptions-=winsize

""""""""""
"  Fold  "
""""""""""
set foldmethod=manual

"""""""""""""
"  Autocmd  "
"""""""""""""
augroup myaug
    autocmd!
    autocmd BufReadPost *
                \   if line("'\"") > 0 && line ("'\"") <= line("$") |
                \       exe "normal g'\"" |
                \   endif
    autocmd FileType help wincmd L
    " autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType markdown hi! ErrorMsg NONE
augroup END

if has('nvim')
    augroup myaug
        autocmd TermOpen * setlocal nonumber | startinsert
    augroup END
endif
