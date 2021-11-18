""""""""""""""
" vimrc home "
""""""""""""""
let g:vimrc_home=expand('<sfile>:p:h')

"""""""""""""""
" Neovim init "
"""""""""""""""
if has('nvim')
    exe "set runtimepath^=".g:vimrc_home
    exe "set runtimepath+=".g:vimrc_home."/after"
    let &packpath=&runtimepath
endif

""""""""""""""""""
" default bundle "
""""""""""""""""""
if !exists('g:bundle_group')
    if argc(-1)>0
        let g:bundle_group=['basic', 'textobj']
    else
        let g:bundle_group=['basic', 'textobj', 'ui', 'snippet', 'comp']
    endif
endif

runtime rany.vim
