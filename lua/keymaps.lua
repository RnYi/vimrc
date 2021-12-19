----------------------------
--  Aliases for Nvim API  --
----------------------------
local g=vim.g
local opt=vim.opt
local map=vim.api.nvim_set_keymap
local cmd=vim.cmd

----------------
--  Internal  --
----------------
g.mapleader=' '
g.maplocalleader=' '
opt.pastetoggle=vim.api.nvim_replace_termcodes('<M-p>', true, true, true)

-----------------
--  Customize  --
-----------------
-- Move between lines
map('', 'H', '^', {noremap=true})
map('', 'L', '$', {noremap=true})
map('', '<M-j>', 'gj', {noremap=true})
map('', '<M-k>', 'gk', {noremap=true})
-- Window operations
map('n', '<M-J>', '<C-w>j', {noremap=true})
map('n', '<M-K>', '<C-w>k', {noremap=true})
map('n', '<M-H>', '<C-w>h', {noremap=true})
map('n', '<M-L>', '<C-w>l', {noremap=true})
map('n', '<M-Q>', '<Cmd>close<CR>', {noremap=true})
map('i', '<M-J>', '<Esc><C-w>j', {noremap=true})
map('i', '<M-K>', '<Esc><C-w>k', {noremap=true})
map('i', '<M-H>', '<Esc><C-w>h', {noremap=true})
map('i', '<M-L>', '<Esc><C-w>l', {noremap=true})
map('i', '<M-Q>', '<Cmd>close<CR>', {noremap=true})
map('t', '<M-J>', '<C-\\><C-N><C-w>j', {noremap=true})
map('t', '<M-K>', '<C-\\><C-N><C-w>k', {noremap=true})
map('t', '<M-H>', '<C-\\><C-N><C-w>h', {noremap=true})
map('t', '<M-L>', '<C-\\><C-N><C-w>l', {noremap=true})
map('t', '<M-Q>', '<C-\\><C-N><Cmd>close<CR>', {noremap=true})
map('t', '<M-q>', '<C-\\><C-N>', {noremap=true})
-- Newline above/below current position (cannot work in terminal)
map('i', '<C-CR>', '<Esc>o', {noremap=true})
map('i', '<S-CR>', '<Esc>O', {noremap=true})
-- Copy/Paste/Cut
map('', '<C-v>', '"+p', {noremap=true})
map('v', '<C-c>', '"+y', {noremap=true})
map('i', '<C-v>', '<C-r>+', {noremap=true})
map('v', '<C-x>', '"+x', {noremap=true})
-- Disable all <*-MiddleMouse>
map('', '<MiddleMouse>', '<Nop>', {noremap=true})
map('i', '<MiddleMouse>', '<Nop>', {noremap=true})
map('', '<2-MiddleMouse>', '<Nop>', {noremap=true})
map('i', '<2-MiddleMouse>', '<Nop>', {noremap=true})
map('', '<3-MiddleMouse>', '<Nop>', {noremap=true})
map('i', '<3-MiddleMouse>', '<Nop>', {noremap=true})
map('', '<4-MiddleMouse>', '<Nop>', {noremap=true})
map('i', '<4-MiddleMouse>', '<Nop>', {noremap=true})
-- Quit to normal mode
map('n', '<C-space>', '<Esc>', {noremap=true})
map('!', '<C-space>', '<Esc>', {noremap=true})
-- Save/delete buffer
map('n', '<M-s>',  '<Cmd>update<CR>',  {noremap=true, silent=true})
map('i', '<M-s>',  '<Cmd>update<CR>',  {noremap=true, silent=true})
map('n', '<M-d>',  '<Cmd>bd<CR>',  {noremap=true, silent=true})
map('n', '<M-d>',  '<Cmd>bd<CR>',  {noremap=true, silent=true})
-- Buffer
map('n', '[b', '<Cmd>bprevious<CR>', {noremap=true, silent=true})
map('n', ']b', '<Cmd>bnext<CR>', {noremap=true, silent=true})
map('n', '[B', '<Cmd>bfirst<CR>', {noremap=true, silent=true})
map('n', ']B', '<Cmd>blast<CR>', {noremap=true, silent=true})
-- Quickfix
map('n', '[q', '<Cmd>cprevious<CR>', {noremap=true, silent=true})
map('n', ']q', '<Cmd>cnext<CR>', {noremap=true, silent=true})
map('n', '[Q', '<Cmd>cfirst<CR>', {noremap=true, silent=true})
map('n', ']Q', '<Cmd>clast<CR>', {noremap=true, silent=true})
-- Location
map('n', '[l', '<Cmd>lprevious<CR>', {noremap=true, silent=true})
map('n', ']l', '<Cmd>lnext<CR>', {noremap=true, silent=true})
map('n', '[L', '<Cmd>lfirst<CR>', {noremap=true, silent=true})
map('n', ']L', '<Cmd>llast<CR>', {noremap=true, silent=true})
-- Space
map('n', '[<Space>', '<Cmd>put!=nr2char(10)<CR>', {noremap=true, silent=true})
map('n', ']<Space>', '<Cmd>put=nr2char(10)<CR>', {noremap=true, silent=true})
-- Toggle window maximized
cmd([[
function! MaximizeToggle() abort
    if exists('g:GuiLoaded')
        call GuiWindowMaximized(1-g:GuiWindowMaximized)
    endif
endfunction
]])
map('', '<F11>', '<Cmd>call MaximizeToggle()<CR>', {noremap=true})
map('i', '<F11>', '<Cmd>call MaximizeToggle()<CR>', {noremap=true})
map('t', '<F11>', '<Cmd>call MaximizeToggle()<CR>', {noremap=true})
-- Use q to quit quickfix and help
-- cmd([[
-- augroup rany_aug
--     autocmd FileType qf nnoremap <buffer> q <Cmd>close<CR>
--     autocmd FileType help nnoremap <buffer> q <Cmd>helpclose<CR>
-- augroup END
-- ]])
-- Map meta key
cmd([[
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

" fix <F1>~<F4> under terminal
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
]])
