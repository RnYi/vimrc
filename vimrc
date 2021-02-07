if !exists('g:vimrc_path')
    if has('win32')
        let g:vimrc_path=expand("~/vimfiles")
    else
        let g:vimrc_path=expand("~/.vim")
    endif
endif
let &pythonthreedll="python38.dll"
colorscheme slate
exe "source ".g:vimrc_path."/vimrc.min"
set showmode
set showtabline=1
