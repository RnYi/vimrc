noremap H ^
noremap L $

nnoremap n nzz
nnoremap N Nzz

nnoremap <M-j> gj
nnoremap <M-k> gk

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

noremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>

noremap <C-space> <ESC>
noremap! <C-space> <ESC>

nnoremap <silent> <M-s> <Cmd>update<CR>
inoremap <silent> <M-s> <Cmd>update<CR>

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

function! FullscreenToggle() abort
    if exists('g:GuiLoaded')
        call GuiWindowFullScreen(1-g:GuiWindowFullScreen)
    elseif exists('g:loaded_shell')
        silent exe "Fullscreen"
    endif
endfunction

noremap <F11> <Cmd>call FullscreenToggle()<CR>
inoremap <F11> <Cmd>call FullscreenToggle()<CR>

if has('nvim')
    tnoremap <M-J> <C-\><C-N><C-w>j
    tnoremap <M-K> <C-\><C-N><C-w>k
    tnoremap <M-H> <C-\><C-N><C-w>h
    tnoremap <M-L> <C-\><C-N><C-w>l
    tnoremap <M-Q> <C-\><C-N><C-w>q
    tnoremap <M-q> <C-\><C-N>
else
    tnoremap <M-q> <C-w>N
    tnoremap <M-J> <C-w>j
    tnoremap <M-K> <C-w>k
    tnoremap <M-H> <C-w>h
    tnoremap <M-L> <C-w>l
    tnoremap <M-Q> <C-w>q
endif
