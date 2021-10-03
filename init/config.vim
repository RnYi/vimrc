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
set undofile
if has('nvim')
    exe "set undodir=".g:vimrc_home."/undofiles/nvim"
else
    exe "set undodir=".g:vimrc_home."/undofiles/vim"
endif

""""""""""""
"  Indent  "
""""""""""""
set tabstop=4 shiftwidth=4
set expandtab
set shiftround
set autoindent smartindent

"""""""""""""
"  Display  "
"""""""""""""
set wrap
set title titlestring=%{getcwd()}
set hidden
set number
set wildmenu
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
set formatoptions+=mMj
set list listchars=nbsp:␣,trail:·,extends:⟩,precedes:⟨
" set guicursor+=a:blinkon0
let &t_EI .= "\<Esc>[1 q"
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
function! StlFilePath()
    let l:rlpath=expand('%')
    let l:fern_path_pat='\Vfern://\.\+/file:///\zs\.\*\ze;\.\+$\$'
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
                \          &filetype ==? ''?"[noft]": '['.&filetype .']'
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
set statusline+=%q
set statusline+=%{StlFilePath()}
set statusline+=\ 
set statusline+=%h
set statusline+=%r
set statusline+=%m
set statusline+=\ 
set statusline+=%{exists('g:did_coc_loaded')?coc#status():''}
set statusline+=%=
set statusline+=%{StlFormat()}
set statusline+=\ 
set statusline+=%{StlFiletype()}

"""""""""""
"  Theme  "
"""""""""""
" sonokai
" let g:sonokai_disable_italic_comment = 1
" let g:sonokai_better_performance = 1
" colorscheme sonokai

" ayu
" let ayucolor="light"
" colorscheme ayu
" hi VertSplit guifg=grey guibg=NONE

" solarized8
let g:solarized_italics=0
let g:solarized_extra_hi_groups=1
let curTimeHour = strftime("%H")
if curTimeHour > 7 && curTimeHour < 18
    set background=light
else
    set background=dark
endif
colorscheme solarized8_flat

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
scriptencoding utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gb18030,gbk,gb2312,cp936
if has('gui_running')
    if g:sys_uname=='windows'
        set guifont=MesloLGS\ NF:h14
        set guifontwide=等距更纱黑体\ SC:h14
    elseif g:sys_uname=='linux'
        set guifont=MesloLGS\ Nerd\ Font\ 14
        set guifont=等距更纱黑体\ SC\ 14
    endif
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
augroup MyAug
    autocmd!
    autocmd BufReadPost *
                \   if line("'\"") > 0 && line ("'\"") <= line("$") |
                \       exe "normal g'\"" |
                \   endif
    autocmd BufEnter *.txt if &buftype=='help' | wincmd L | endif
    " autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType markdown hi! ErrorMsg NONE
augroup END

if has('nvim')
    augroup MyAug
        autocmd TermOpen * setlocal nonumber | startinsert
    augroup END
endif
