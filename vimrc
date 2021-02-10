if !exists('g:vimrc_path')
    if has('win32')
        let g:vimrc_path=expand("~/vimfiles")
    else
        let g:vimrc_path=expand("~/.vim")
    endif
endif
exe "so ".g:vimrc_path."/vimrc.min"

call plug#begin()
Plug 'ayu-theme/ayu-vim'
call plug#end()

let &pythonthreedll="python38.dll"
set showmode

let ayucolor="dark"
colorscheme ayu
