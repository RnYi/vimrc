if !exists('g:vimrc_home')
    let g:vimrc_home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
    let g:init_home=g:vimrc_home."/init"
endif

exe "so ".g:vimrc_home."/vimrc.min"
let &pythonthreedll="python38.dll"
set showmode

