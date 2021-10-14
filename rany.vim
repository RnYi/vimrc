""""""""""""""""""
"  OS detection  "
""""""""""""""""""
if !exists('g:sys_uname')
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
endif

"""""""""""""""
"  vimrc dir  "
"""""""""""""""
if !exists('g:vimrc_home')
    let g:vimrc_home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
endif
if !exists('g:init_home')
    let g:init_home=g:vimrc_home."/init"
endif

""""""""""""""""""""
"  define HasPlug  "
""""""""""""""""""""
function! HasPlug(name) abort
    "depending on vim-plug
    return exists('g:loaded_plug')?index(g:plugs_order,a:name) != -1:0
endfunction

"""""""""""""""""""""""
"  vim-plug setting  "
"""""""""""""""""""""""
let g:plug_url_format='git@github.com:%s.git'

"""""""""""""""""""""""""""
"  pythonthreedll setting "
"""""""""""""""""""""""""""
if !has('nvim')&&g:sys_uname=='windows'&&!exists('g:pythree_version')&&executable('python')
    let g:pythree_version=system("python -V")
    let g:pythree_version=split(g:pythree_version)[1]
    let g:pythree_version=split(g:pythree_version,'\.')
    let g:pythree_version=g:pythree_version[0].g:pythree_version[1]
    let &pythonthreedll="python".g:pythree_version.".dll"
endif

"""""""""""""""""""
"  load plug-ins  "
"""""""""""""""""""
" bundle_group items: basic, textobj, ui, snippet, comp
if !exists('g:bundle_group')
    let g:bundle_group=[]
endif
let g:bundle_enabled={}
for key in g:bundle_group | let g:bundle_enabled[key] = 1 | endfor

call plug#begin()

""""""""""""""""""""
"  bundle - basic  "
""""""""""""""""""""
if has_key(g:bundle_enabled, 'basic')
    " Theme
    Plug 'sainnhe/edge', {'dir': g:vimrc_home.'/colors/edge'}
    " Statusline
    Plug 'itchyny/lightline.vim'
    " Indent line
    Plug 'Yggdroot/indentLine', {'on': 'IndentLinesToggle'}
    " Comment
    Plug 'tpope/vim-commentary'
    " Surround
    Plug 'machakann/vim-sandwich'
    " Align
    Plug 'godlygeek/tabular', {'on':['Tabularize','AddTabularPatter','AddTabularPipeline']}
    Plug 'tweekmonster/startuptime.vim', {'on':'StartupTime'}
    " Markdown
    Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    " Latex
    Plug 'lervag/vimtex', {'for': ['tex','latex']}
    " Input method
    if g:sys_uname!='windows'
        Plug 'rlue/vim-barbaric'
    endif
    Plug 'octol/vim-cpp-enhanced-highlight', {'for':['cpp']}
endif

""""""""""""""""""""""
"  bundle - textobj  "
""""""""""""""""""""""
if has_key(g:bundle_enabled, 'textobj')
    " Text objects
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'sgur/vim-textobj-parameter'
endif

"""""""""""""""""
"  bundle - ui  "
"""""""""""""""""
if has_key(g:bundle_enabled, 'ui')
    " Start-up
    Plug 'mhinz/vim-startify'
    " Show buffers on tabline
    Plug 'ap/vim-buftabline'
    " Plug 'bling/vim-bufferline'
    " File explorer
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    if has('nvim')
        Plug 'antoinemadec/FixCursorHold.nvim'
    endif
endif

""""""""""""""""""""""
"  bundle - snippet  "
""""""""""""""""""""""
if has_key(g:bundle_enabled, 'snippet')
    " Snippets
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips' " depending on python
endif

"""""""""""""""""""
"  bundle - comp  "
"""""""""""""""""""
if has_key(g:bundle_enabled, 'comp')
    " Completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " depending on nodejs
    " Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['c','cpp']}
    " Asynctasks
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'
    " Tags
    Plug 'ludovicchabant/vim-gutentags' " depending on gtags and pygments(python module)
    Plug 'skywind3000/gutentags_plus'
    " Treesitter
    " if has('nvim')
    "     Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " endif
endif

call plug#end()

"""""""""""""""""""""""""""
"  source other settings  "
"""""""""""""""""""""""""""
exe "so ".g:init_home."/config.vim"
exe "so ".g:init_home."/keymaps.vim"
if !empty(g:bundle_enabled)
    exe "so ".g:init_home."/plugins.vim"
endif
