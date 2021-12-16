let g:vimrc_home=expand('<sfile>:p:h')
if has('nvim')
    exe 'set runtimepath^='.g:vimrc_home
    exe 'set runtimepath+='.g:vimrc_home.'/after'
    let &packpath=&runtimepath
    exe 'luafile '.g:vimrc_home.'/nvim/init.lua'
endif
