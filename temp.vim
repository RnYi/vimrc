let g:vimrc_home=expand('<sfile>:p:h')
let g:node_host_prog='C:/Users/Richard/AppData/Roaming/npm/node_modules/neovim'
if has('nvim')
    exe 'set runtimepath^='.g:vimrc_home
    exe 'set runtimepath+='.g:vimrc_home.'/after'
    lua require('init')
else
endif
