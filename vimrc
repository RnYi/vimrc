""""""""""""""""""
"  启用vim-plug  "
""""""""""""""""""
call plug#begin()
" 颜色主题
Plug 'lifepillar/vim-solarized8'
" 彩色括号
Plug 'luochen1990/rainbow'
" 缩进线
Plug 'Yggdroot/indentLine'
" 状态栏
Plug 'itchyny/lightline.vim'
" 标签栏
Plug 'ap/vim-buftabline'
" 补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight',{'for':['c','cpp','c++']}
" 分隔符
Plug 'Raimondi/delimitMate'
" 显示函数签名
Plug 'Shougo/echodoc.vim'
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Latex
Plug 'lervag/vimtex'
" 文件管理
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
if has('nvim')
    Plug 'antoinemadec/FixCursorHold.nvim'
endif
" 移动增强
Plug 'justinmk/vim-sneak'
" 启动界面
Plug 'mhinz/vim-startify'
" 快速注释
Plug 'preservim/nerdcommenter'
" 环绕符号
Plug 'tpope/vim-surround'
" 全屏
if !has('nvim')
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-shell'
endif
" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" 异步任务
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
" jk退出插入模式
Plug 'jdhao/better-escape.vim'
call plug#end()

""""""""""""""
"  基础设置  "
""""""""""""""
set mouse-=a                   " 使用鼠标模式
set autoread
if !has('win32')
    set shellslash
endif
set shortmess+=c
if !has('nvim')
    set nocompatible               " 非兼容模式
endif
set updatetime=300
set backspace=indent,eol,start " 设置退格键
syntax on
filetype on                    " 自动检测文件类型
filetype plugin on
filetype indent on
let g:mapleader="\<Space>"
" 打开文件时跳转到最后一次编辑的位置
autocmd BufReadPost *
            \   if line("'\"") > 0 && line ("'\"") <= line("$") |
            \       exe "normal g'\"" |
            \   endif
" help文档始终以垂直分屏方式打开
autocmd FileType help wincmd L
" 高亮json里的注释
autocmd FileType json syntax match Comment +\/\/.\+$+

""""""""""""""
"  缩进设置  "
""""""""""""""
set tabstop=4
set smarttab
set expandtab     " 空格代替制表符
set shiftround
set autoindent    " 根据前面的行设置缩进
set smartindent
set shiftwidth=4  " >>缩进4个空格
set softtabstop=4 " 将制表符设为4个空格
autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2

""""""""""“”""
"  显示设置  "
""""""""""“”""
set hidden
" set relativenumber
set nonumber  " 不显示行号
set noshowcmd " 不显示已经输入的键
" 设置折行
set wrap
set linebreak
set breakat-=_
set wildmenu
set noshowmode       " 不显示当前模式
set cursorline       " 快速找到当前行
set scrolloff=1
set sidescrolloff=5
set laststatus=2     " 总是显示状态行
set showtabline=2
set guioptions-=T    " 去掉工具栏
set guioptions-=m    " 去掉菜单栏
set guioptions-=e    " 去掉标签页
set guioptions-=r    " 去掉右边滚动条
set guioptions-=L    " 分屏时去掉左边滚动条
set guioptions+=c    " 不弹出选项菜单
set termguicolors
set signcolumn=yes
set display=lastline " 尽可能显示最后一行
set formatoptions+=mMj
if has('gui_running')
    set gcr=a:blinkon0
    autocmd GUIEnter * set lines=30 | set columns=90 | winpos 435 120
endif
""""""""“”""“”
"  查找设置  "
""""""""""“”“”
set wrapscan
set smartcase
set nohlsearch 
set incsearch     " 增量搜索
set ignorecase    " 忽略大小写
if has('nvim')
    set inccommand=nosplit
endif

""""""""""""“”
"  编码设置  "
""""""""""""“”
language en_US
set langmenu=en_US    " 设置语言为en_US
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set guifont=MesloLGS\ NF:h14
set guifontwide=等距更纱黑体\ SC:h14
set fileencodings=utf-8,ucs-bom,chinese,gb18030,gbk,gb2312,cp936

""""""""""""""
"  会话设置  "
""""""""""""""
set viewoptions-=options
set sessionoptions-=options
set sessionoptions+=globals

""""""""""“”“”
"  主题设置  "
""""""""""“”“”
set background=dark
let g:solarized_italics=0
colorscheme solarized8_flat

""""""""""""""
"  标题设置  "
""""""""""""""

""""""""""""""
"  折叠设置  "
""""""""""""""
set foldmethod=manual

"""""""""""""""""""
"  neovim-qt设置  "
"""""""""""""""""""

""""""""""""""
"  插件设置  "
""""""""""""""
" IndentLien
let g:indentLine_enabled=0
nnoremap <silent> <F2> <Cmd>IndentLinesToggle<CR>

" echodoc
let g:echodoc_enable_at_startup=1

" vim-lsp-cxx-highlight
let g:cpp_class_decl_highlight=1
let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1

" vim-sneak
let g:sneak#label=1
let g:sneak#use_ic_scs=1

" better-escape
let g:better_escape_interval = 100
let g:better_escape_shortcut=['jk','kj']

" vim-shell
if !has('nvim')
    let g:shell_mappings_enabled=0
    let g:shell_fullscreen_message=0
    let g:shell_fullscreen_items='mT'
    let g:shell_fullscreen_always_on_top=0
    if has('gui_running') && has('win32')
        nnoremap <silent> <F11> <Cmd>Fullscreen<CR>
        inoremap <silent> <F11> <Cmd>Fullscreen<CR>
    endif
endif

" vim-markdown
let g:vim_markdown_math = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
" markdown-preview
let g:mkdp_auto_close=0
nmap <Leader>p <Plug>MarkdownPreviewToggle

" vimtex
let g:tex_flavor='tex'

" delimitMate
let delimitMate_expand_cr=1
let delimitMate_matchpairs=&matchpairs
let delimitMate_quotes="\" ' `"
autocmd FileType python let b:delimitMate_nesting_quotes=['"']
autocmd FileType markdown,latex let b:delimitMate_quotes=delimitMate_quotes." \$"

" fern
let g:fern#smart_cursor="hide"
let g:fern#disable_default_mappings=1
let g:fern#disable_auto_buffer_delete=1
let g:fern#renderer#default#leaf_symbol="| "
let g:fern#renderer#default#expanded_symbol="\u25be "
let g:fern#renderer#default#collapsed_symbol="\u25b8 "
function! s:init_fern() abort
    setlocal nonu
    nmap <buffer><expr>
                \ <Plug>(fern-my-open-or-expand-or-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open)",
                \   "\<Plug>(fern-action-expand:stay)",
                \   "\<Plug>(fern-action-collapse)",
                \ )
    nmap <buffer><silent> e    <Plug>(fern-action-open:tabedit)
    nmap <buffer><silent> o    <Plug>(fern-my-open-or-expand-or-collapse)
    nmap <buffer><silent> go   <Plug>(fern-action-open:edit)<C-w>p
    nmap <buffer><silent> t    <Plug>(fern-action-open:tabedit)
    nmap <buffer><silent> T    <Plug>(fern-action-open:tabedit)gT
    nmap <buffer><silent> ma   <Plug>(fern-action-new-path)
    nmap <buffer><silent> mc   <Plug>(fern-action-copy)
    nmap <buffer><silent> md   <Plug>(fern-action-trash)
    nmap <buffer><silent> mm   <Plug>(fern-action-move)
    nmap <buffer><silent> mr   <Plug>(fern-action-rename)

    nmap <buffer><silent> cc   <Plug>(fern-action-clipboard-copy)
    nmap <buffer><silent> cp   <Plug>(fern-action-clipboard-paste)
    nmap <buffer><silent> cm   <Plug>(fern-action-clipboard-move)
    nmap <buffer><silent> cr   <Plug>(fern-action-clipboard-clear)
    nmap <buffer><silent> l    <Plug>(fern-action-enter)
    nmap <buffer><silent> h    <Plug>(fern-action-leave)
    nmap <buffer><silent> r    <Plug>(fern-action-reload)
    nmap <buffer><silent> x    <Plug>(fern-action-collapse)
    nmap <buffer><silent> R  gg<Plug>(fern-action-reload)<C-o>
    nmap <buffer><silent> cd   <Plug>(fern-action-tcd:cursor)
    nmap <buffer><silent> CD <Cmd>Fern . -drawer -keep<CR>

    nmap <buffer><silent> -    <Plug>(fern-action-mark:toggle)
    nmap <buffer><silent> _    <Plug>(fern-action-mark:clear)
    nmap <buffer><silent> I    <Plug>(fern-action-hidden:toggle)

    nmap <buffer><silent> q <Cmd>quit<CR>
endfunction
augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END
nnoremap <silent> <Leader>e <Cmd>Fern . -drawer -keep -toggle<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-l>"
inoremap <C-x><C-k> <C-x><C-k>

" startify
let g:startify_change_cmd='tcd'
let g:startify_session_sort = 1
let g:startify_files_number = 5
let g:startify_session_number = 5
let g:startify_update_oldfiles = 1
let g:startify_session_persistence=1
let g:startify_session_delete_buffers=1
let g:startify_lists=[
            \   { 'type': 'sessions',  'header': ['   Sessions']       },
            \   { 'type': 'files',     'header': ['   MRU']            },
            \]

" NERDCommenter
" 注释符号后加一个空格
let g:NERDSpaceDelims=1
" 更好看的多行注释
let g:NERDCompactSexyComs=1
" 允许注释空行
let g:NERDCommentEmptyLines=1
" 取消默认键映射
let g:NERDCreateDefaultMappings=1
" 取消注释时删去空格
let g:NERDTrimTrailingWhitespace=1
" 检查所有行的状态
let g:NERDToggleCheckAllLines=1
let g:NERDCustomDelimiters={'json':{'left':'//'}}

" AsyncTasks
autocmd BufRead,BufNewFile .tasks set filetype=tasks
autocmd BufRead,BufNewFile tasks.ini set filetype=tasks
let g:asyncrun_open=6
let g:asynctasks_term_reuse=1
let g:asynctasks_term_pos='tab'
let g:asynctasks_extra_config=[
            \ '~/vimfiles/tasks.ini',
            \ ]
let g:asyncrun_rootmarks=['.root','.project','.git','.hg','.svn','.projections.json']
nnoremap <silent> <F5> <Cmd>AsyncTask file-run<CR>
nnoremap <silent> <F6> <Cmd>AsyncTask file-build<CR>
nnoremap <silent> <F7> <Cmd>AsyncTask project-run<CR>
nnoremap <silent> <F8> <Cmd>AsyncTask project-build<CR>
inoremap <silent> <F5> <Cmd>AsyncTask file-run<CR>
inoremap <silent> <F6> <Cmd>AsyncTask file-build<CR>
inoremap <silent> <F7> <Cmd>AsyncTask project-run<CR>
inoremap <silent> <F8> <Cmd>AsyncTask project-build<CR>

" Rainbow Parentheses
let g:rainbow_active=1
let g:rainbow_conf={
            \   'guifgs':['white','gold','chocolate','magenta','OrangeRed'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold',
            \                   'start=/\[/ end=/\]/ fold',
            \                   'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'nerdtree':0,
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
            \       },
            \       'vim': {
            \           'parentheses':
            \               ['start=/(/ end=/)/',
            \                'start=/\[/ end=/\]/',
            \                'start=/{/ end=/}/ fold',
            \                'start=/(/ end=/)/ containedin=vimFuncBody',
            \                'start=/\[/ end=/\]/ containedin=vimFuncBody',
            \                'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}

" lightline
let g:lightline={
            \   'colorscheme':'solarized',
            \   'active' : {
            \       'left': [['mode', 'paste'],['relativepath'],['cocstatus']],
            \       'right' : [['filetype'],['lineinfo']]
            \   },
            \   'inactive':{
            \       'left':[['relativepath']],
            \       'right' : [['filetype']]
            \},
            \   'enable':{
            \       'statusline':1,
            \       'tabline':0
            \   },
            \   'component_function': {
            \       'mode':'LightlineMode',
            \       'cocstatus':'coc#status',
            \       'relativepath':'LightlinePath',
            \       'filetype':'LightlineFiletype',
            \       'lineinfo':'LightlineLineinfo',
            \   },
            \}
function! LightlineMode()
    return &filetype ==? 'fern' ? 'Fern' :
                \          &filetype ==? 'startify' ? 'Startify' :
                \          lightline#mode()
endfunction

function! LightlinePath()
    let l:rlpath=expand('%')
    return &filetype ==? 'fern' ? '' : 
                \          &filetype ==? 'startify' ? '' :
                \          &filetype ==? 'help' ? expand('%:t') :
                \          &filetype == '' ? '' :
                \          winwidth('%') < 40 ? '' :
                \          strchars(l:rlpath) < 20 ? l:rlpath : pathshorten(l:rlpath)
endfunction

function! LightlineFiletype()
    return &filetype ==? 'fern' ? '' :
                \          &filetype ==? 'startify' ? '' :
                \          winwidth('%') > 70 ? &filetype : ''
endfunction

function! LightlineLineinfo()
    return &filetype ==? 'fern' ? '' :
                \          &filetype ==? 'startify' ? '' :
                \          winwidth('%') > 70 ? printf("%d/%d", line('.'),line('$')) : ''
endfunction

" vim-buftabline
let g:buftabline_numbers=2
let g:buftabline_indicators=1
nnoremap <silent> <TAB> <Cmd>bn<CR>
nnoremap <silent> <S-TAB> <Cmd>bp<CR>
nnoremap <silent> <Leader>d <Cmd>bd<CR>
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

" coc-nvim
let g:markdown_fenced_languages= ['vim','help','css', 'js=javascript']
let g:coc_global_extensions=["coc-clangd","coc-json","coc-vimlsp","coc-cmake","coc-tasks","coc-pyright","coc-html","coc-ultisnips","coc-vimtex"]
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-refrences)
nmap <Leader>rn <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K <Cmd>call <SID>show_documentation()<CR>
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


""""""""""“”“”
"  按键映射  "
""""""""""“”“”
noremap H ^
noremap L $

nnoremap n nzz
nnoremap N Nzz

nnoremap <M-j> jzz
nnoremap <M-k> kzz

nnoremap <M-J> <C-w>j
nnoremap <M-K> <C-w>k
nnoremap <M-H> <C-w>h
nnoremap <M-L> <C-w>l
nnoremap <M-Q> <C-w>q
inoremap <M-J> <ESC><C-w>j
inoremap <M-K> <ESC><C-w>k
inoremap <M-H> <ESC><C-w>h
inoremap <M-L> <ESC><C-w>l
inoremap <M-Q> <ESC><C-w>q

inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <Left>
inoremap <M-l> <Right>

cnoremap <M-h> <Left>
cnoremap <M-l> <Right>

inoremap <M-CR> <ESC>o
inoremap <S-CR> <ESC>O

map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

nnoremap <silent> <M-s> <Cmd>update<CR>
inoremap <silent> <M-s> <Cmd>update<CR>

nnoremap <silent><expr> q &filetype==#'help'?":bd\<CR>":'q'

if has('nvim')
    tnoremap <M-J> <C-\><C-N><C-w>j
    tnoremap <M-K> <C-\><C-N><C-w>k
    tnoremap <M-H> <C-\><C-N><C-w>h
    tnoremap <M-L> <C-\><C-N><C-w>l
    tnoremap <M-Q> <C-\><C-N><C-w>q
    tnoremap <M-q> <C-\><C-N>
    vnoremap <silent> <C-Insert> "+y
    vnoremap <silent> <S-Insert> "+p
    inoremap <silent> <S-Insert> <C-r>+
    nnoremap <silent> <S-Insert> "+p
    nnoremap <silent> <F11> <Cmd>call FullScreenToggle()<CR>
    inoremap <silent> <F11> <Cmd>call FullScreenToggle()<CR>
    function! FullScreenToggle() abort
        if g:GuiWindowFullScreen
            call GuiWindowFullScreen(0)
        else
            call GuiWindowFullScreen(1)
        endif
    endfunction
    autocmd TermOpen * setlocal nonumber | startinsert
    autocmd SessionLoadPost * let g:GuiWindowFullScreen=0
else
    tnoremap <M-q> <C-w>N
    tnoremap <M-J> <C-w>j
    tnoremap <M-K> <C-w>k
    tnoremap <M-H> <C-w>h
    tnoremap <M-L> <C-w>l
    tnoremap <M-Q> <C-w>q
endif
