noremap H ^
noremap L $

nnoremap n nzz
nnoremap N Nzz

nnoremap <M-j> gj
nnoremap <M-k> gk

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

map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

noremap <C-space> <ESC>
noremap! <C-space> <ESC>

nnoremap <silent> <M-s> <Cmd>update<CR>
inoremap <silent> <M-s> <Cmd>update<CR>

nnoremap <silent> <TAB> <Cmd>bn<CR>
nnoremap <silent> <S-TAB> <Cmd>bp<CR>
nnoremap <silent> <Leader>d <Cmd>bd<CR>

inoremap <C-x><C-k> <C-x><C-k>

nnoremap <silent><expr> q index(['help','quickfix'], &buftype) >= 0 ? ":bd\<CR>":'q'

if has('nvim')
    tnoremap <M-J> <C-\><C-N><C-w>j
    tnoremap <M-K> <C-\><C-N><C-w>k
    tnoremap <M-H> <C-\><C-N><C-w>h
    tnoremap <M-L> <C-\><C-N><C-w>l
    tnoremap <M-Q> <C-\><C-N><C-w>q
    tnoremap <M-q> <C-\><C-N>
    vnoremap <silent> <C-Insert> "+y
    vnoremap <silent> <S-Insert> "+p
    inoremap <silent> <S-Insert> <C-r>+
    nnoremap <silent> <S-Insert> "+p
    nnoremap <silent> <F1> <Cmd>call FullScreenToggle()<CR>
    inoremap <silent> <F1> <Cmd>call FullScreenToggle()<CR>
    tnoremap <silent> <F1> <Cmd>call FullScreenToggle()<CR>
    function! FullScreenToggle() abort
        if g:GuiWindowFullScreen
            call GuiWindowFullScreen(0)
        else
            call GuiWindowFullScreen(1)
        endif
    endfunction
    augroup myaug
        autocmd TermOpen * setlocal nonumber | startinsert
        autocmd SessionLoadPost * let g:GuiWindowFullScreen=0
    augroup END
else
    tnoremap <M-q> <C-w>N
    tnoremap <M-J> <C-w>j
    tnoremap <M-K> <C-w>k
    tnoremap <M-H> <C-w>h
    tnoremap <M-L> <C-w>l
    tnoremap <M-Q> <C-w>q
endif
