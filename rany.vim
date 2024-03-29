"""""""""""""""""""""
"  some detections  "
"""""""""""""""""""""

"""""""""""""""
"  vimrc dir  "
"""""""""""""""
if !exists('g:vimrc_home')
  let g:vimrc_home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
endif
if !exists('g:init_home')
  let g:init_home=g:vimrc_home."/init"
endif

"""""""""""""""""""""""
"  vim-plug setting  "
"""""""""""""""""""""""
let g:plug_url_format=g:repo_url.'/%s.git'

"""""""""""""""""""""
"  langugae support "
"""""""""""""""""""""
" if g:is_vim&&g:sys_uname=='windows'&&!exists('g:pythree_version')
"     let g:pythree_version=system("python -V")
"     let g:pythree_version=split(g:pythree_version)[1]
"     let g:pythree_version=split(g:pythree_version,'\.')
"     let g:pythree_version=g:pythree_version[0].g:pythree_version[1]
"     let &pythonthreedll="python".g:pythree_version.".dll"
" endif
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider=0
let g:loaded_python_provider = 0
let g:python3_host_prog='python3'

"""""""""""""""""""
"  load plug-ins  "
"""""""""""""""""""
" bundle_group items: basic, textobj, ui, snippet, comp, tags
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
  Plug 'sainnhe/gruvbox-material'
  " Statusline
  Plug 'itchyny/lightline.vim'
  " Indent line
  Plug 'Yggdroot/indentLine'
  " Comment
  Plug 'tpope/vim-commentary'
  " Surround
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  " Delimit
  Plug 'Raimondi/delimitMate'
  " Align
  Plug 'junegunn/vim-easy-align', {'on':'EasyAlign'}
  " Startup
  Plug 'tweekmonster/startuptime.vim', {'on':'StartupTime'}
  " Markdown
  Plug 'plasticboy/vim-markdown', {'for':['markdown']}
  Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  " Latex
  Plug 'lervag/vimtex', {'for': ['tex','latex']}
  " Input method
  if g:sys_uname!='win'
    Plug 'lyokha/vim-xkbswitch'
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
  Plug 'lambdalisue/fern-hijack.vim'
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
endif

if has_key(g:bundle_enabled, 'tags')
  " Tags
  Plug 'ludovicchabant/vim-gutentags' " depending on gtags and pygments(python module)
  Plug 'skywind3000/gutentags_plus'
  Plug 'liuchengxu/vista.vim', {'on':['Vista']}
endif

call plug#end()

"""""""""""""""""""
"  plugins list  "
"""""""""""""""""""
let g:plugs_enabled={}
if exists('g:loaded_plug')
  for key in g:plugs_order | let g:plugs_enabled[key]=1|endfor
endif

"""""""""""""""""""""""""""
"  source other settings  "
"""""""""""""""""""""""""""
exe "so ".g:init_home."/config.vim"
exe "so ".g:init_home."/keymaps.vim"
if !empty(g:bundle_enabled)
  exe "so ".g:init_home."/plugins.vim"
endif
