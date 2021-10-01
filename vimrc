""""""""""""""""""
"  操作系统辨识  "
""""""""""""""""""
if has('win32') || has('win64') || has('win95') || has('win16')
    let g:sys_uname='windows'
elseif has('unix')
    let s:uname = substitute(system("uname"), '\s*\n$', '', 'g')
    if v:shell_error == 0 && match(s:uname, 'Linux') >= 0
        let g:sys_uname = 'linux'
    elseif v:shell_error == 0 && match(s:uname, 'FreeBSD') >= 0
        let g:sys_uname = 'freebsd'
    elseif v:shell_error == 0 && match(s:uname, 'Darwin') >= 0
        let g:sys_uname = 'darwin'
    else
        let g:sys_uname = 'posix'
    endif
else
    let g:sys_uname = 'posix'
endif

"""""""""""""""""""""""
"  设置vimrc所在目录  "
"""""""""""""""""""""""
if !exists('g:vimrc_home')
    let g:vimrc_home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
    let g:init_home=g:vimrc_home."/init"
endif

""""""""""""""""""
"  vim-plug配置  "
""""""""""""""""""
let g:plug_url_format='git@github.com:%s.git'

"""""""""""""""""""
"  pythondll设置  "
"""""""""""""""""""
if !has('nvim') && g:sys_uname=='windows'
    let ver_str=system("python -V")
    let ver_str=split(ver_str)[1]
    let ver_str=split(ver_str,'\.')
    let ver_str=ver_str[0].ver_str[1]
    let &pythonthreedll="python".ver_str.".dll"
endif

""""""""""""""
"  添加插件  "
""""""""""""""
if !exists('g:bundle_name')
    if argc(-1)>0
        let g:bundle_name='basic'
    else
        let g:bundle_name='max'
    endif
endif
call plug#begin()
" Theme
Plug 'sainnhe/sonokai'
" Indent line
Plug 'Yggdroot/indentLine', {'on': 'IndentLinesToggle'}
" Comment
Plug 'tpope/vim-commentary'
" Surround
Plug 'machakann/vim-sandwich'
" Align
Plug 'godlygeek/tabular', {'on':['Tabularize','AddTabularPatter','AddTabularPipeline']}
" Input method
if g:sys_uname!='windows'
    Plug 'rlue/vim-barbaric'
endif
" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'sgur/vim-textobj-parameter'
if g:bundle_name=='max'
    " Show buffers on tabline
    Plug 'ap/vim-buftabline'
    " Completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['c','cpp']}
    " Markdown
    Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
    " Latex
    Plug 'lervag/vimtex', {'for': ['tex','latex']}
    " File explorer
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    if has('nvim')
        Plug 'antoinemadec/FixCursorHold.nvim'
    endif
    " Start-up
    Plug 'mhinz/vim-startify'
    Plug 'tweekmonster/startuptime.vim', {'on':'StartupTime'}
    " Snippets
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    " Asynctasks
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'
    " Treesitter
    if has('nvim')
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    endif
endif
call plug#end()

""""""""""""""""""
"  加载其他设置  "
""""""""""""""""""
exe "so ".g:init_home."/config.vim"
exe "so ".g:init_home."/keymaps.vim"
exe "so ".g:init_home."/plugins.vim"
