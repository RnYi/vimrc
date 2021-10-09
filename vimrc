if !exists('g:bundle_group')
    if argc(-1)>0
        let g:bundle_group=['basic', 'textobj']
    else
        let g:bundle_group=['basic', 'textobj', 'ui', 'snippet', 'comp']
    endif
endif
runtime rany.vim
