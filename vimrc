if !exists('g:vimrc_home')
    let g:vimrc_home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
    let g:init_home=g:vimrc_home."/init"
endif

" load vim-shell
call plug#begin()
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'
call plug#end()

" load config
exe "so ".g:vimrc_home."/vimrc.min"
let &pythonthreedll="python38.dll"
set showmode

" set vim-shell
let g:shell_mappings_enabled=0
let g:shell_fullscrejen_message=0
let g:shell_fullscreen_items='mT'
let g:shell_fullscreen_always_on_top=0
