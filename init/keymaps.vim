noremap H ^
noremap L $

nnoremap n nzz
nnoremap N Nzz

noremap <M-j> gj
noremap <M-k> gk

noremap <TAB> %

nnoremap <M-J> <C-w>j
nnoremap <M-K> <C-w>k
nnoremap <M-H> <C-w>h
nnoremap <M-L> <C-w>l
nnoremap <M-Q> <C-w>q
inoremap <M-J> <ESC><C-w>j
inoremap <M-K> <ESC><C-w>k
inoremap <M-H> <ESC><C-w>h
inoremap <M-L> <ESC><C-w>l
inoremap <M-Q> <ESC><C-w>q
tnoremap <M-J> <C-\><C-N><C-w>j
tnoremap <M-K> <C-\><C-N><C-w>k
tnoremap <M-H> <C-\><C-N><C-w>h
tnoremap <M-L> <C-\><C-N><C-w>l
tnoremap <M-Q> <C-\><C-N><C-w>q
tnoremap <M-q> <C-\><C-N>
tnoremap <C-v> <C-w>"+

inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <Left>
inoremap <M-l> <Right>

cnoremap <M-h> <Left>
cnoremap <M-l> <Right>

inoremap <C-CR> <ESC>o
inoremap <S-CR> <ESC>O

noremap <C-v> "+p
vnoremap <C-c> "+y
inoremap <C-v> <C-r>+
vnoremap <C-x> "+x

noremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>

noremap <C-space> <ESC>
noremap! <C-space> <ESC>

nnoremap <silent> <M-s> <Cmd>update<CR>
inoremap <silent> <M-s> <Cmd>update<CR>
nnoremap <silent> <M-d> <Cmd>bd<CR>
inoremap <silent> <M-d> <Cmd>bd<CR>

nnoremap <silent> [b <Cmd>bp<CR>
nnoremap <silent> ]b <Cmd>bn<CR>
nnoremap <silent> [B <Cmd>bf<CR>
nnoremap <silent> ]B <Cmd>bl<CR>
nnoremap <silent> [q <Cmd>cp<CR>
nnoremap <silent> ]q <Cmd>cn<CR>
nnoremap <silent> [Q <Cmd>cf<CR>
nnoremap <silent> ]Q <Cmd>cl<CR>
nnoremap <silent> [<Space> <Cmd>put!=nr2char(10)<CR>
nnoremap <silent> ]<Space> <Cmd>put=nr2char(10)<CR>

inoremap <C-x><C-k> <C-x><C-k>

nnoremap <silent><expr> q index(['help','quickfix'], &buftype) >= 0 ? ":bd\<CR>":'q'

" 最大化窗口要用到wmctrl
let g:wmctrl_exec=executable('wmctrl')
function! MaximizeToggle() abort
    " neovim-qt
    if exists('g:GuiLoaded')
        call GuiWindowFullScreen(1-g:GuiWindowFullScreen)
    " linux gvim
    elseif has('gui_running') && g:wmctrl_exec
        call system("wmctrl -ir ".v:windowid." -b toggle,maximized_vert,maximized_horz")
        redraw!
    " windows TODO
    endif
endfunction

noremap <F11> <Cmd>call MaximizeToggle()<CR>
inoremap <F11> <Cmd>call MaximizeToggle()<CR>
tnoremap <F11> <Cmd>call MaximizeToggle()<CR>

" 映射meta键
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

" 修正终端下的<F1>~<F4>
function! Terminal_FunctionKey()
    if &term =~ '^xterm'
        exe "set <F1>=\eOP"
        exe "set <F2>=\eOQ"
        exe "set <F3>=\eOR"
        exe "set <F4>=\eOS"
    endif
endfunction
call Terminal_MetaMode(0)
call Terminal_FunctionKey()
