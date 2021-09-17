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

if !exists('g:vimrc_home')
    let g:vimrc_home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
    let g:init_home=g:vimrc_home."/init"
endif

" vim-plug配置
let g:plug_url_format='git@github.com:%s.git'

" win32下指定vim的py3的dll
if !has('nvim') && g:sys_uname=='windows'
    let &pythonthreedll="python38.dll"
endif

if argc(-1) > 0
" 用vim/nvim打开文件时，加载简化配置
        " 使gvim可以全屏
        call plug#begin()
        if g:sys_uname=='windows' && has('gui_running')
            Plug 'xolox/vim-misc'
            Plug 'xolox/vim-shell'
        endif
        Plug 'sainnhe/sonokai'
        call plug#end()
        let g:shell_mappings_enabled=0
        let g:shell_fullscrejen_message=0
        let g:shell_fullscreen_items='mT'
        let g:shell_fullscreen_always_on_top=0
    exe "so ".g:vimrc_home."/vimrc.min"
    set showmode
else
" 直接启动时，加载完整配置
    exe "so ".g:vimrc_home."/vimrc.max"
endif
