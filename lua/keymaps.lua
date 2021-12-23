----------------------------
--  Aliases for Nvim API  --
----------------------------
local map=vim.api.nvim_set_keymap
local map_opt={noremap=true, silent=true}

----------------
--  Internal  --
----------------
-- Leader key
vim.g.mapleader=' '
vim.g.maplocalleader=' '
-- pastetoggle
vim.opt.pastetoggle=vim.api.nvim_replace_termcodes('<F12>', true, true, true)
-- Move between lines
map('n', 'H', '^', map_opt)
map('n', 'L', '$', map_opt)
map('x', 'H', '^', map_opt)
map('x', 'L', '$', map_opt)
map('', '<M-j>', 'gj', map_opt)
map('', '<M-k>', 'gk', map_opt)
-- Window operations
map('n', '<M-J>', '<C-w>j', map_opt)
map('n', '<M-K>', '<C-w>k', map_opt)
map('n', '<M-H>', '<C-w>h', map_opt)
map('n', '<M-L>', '<C-w>l', map_opt)
map('n', '<M-Q>', '<Cmd>close<CR>', map_opt)
map('i', '<M-J>', '<Esc><C-w>j', map_opt)
map('i', '<M-K>', '<Esc><C-w>k', map_opt)
map('i', '<M-H>', '<Esc><C-w>h', map_opt)
map('i', '<M-L>', '<Esc><C-w>l', map_opt)
map('i', '<M-Q>', '<Cmd>close<CR>', map_opt)
map('t', '<M-J>', '<C-\\><C-N><C-w>j', map_opt)
map('t', '<M-K>', '<C-\\><C-N><C-w>k', map_opt)
map('t', '<M-H>', '<C-\\><C-N><C-w>h', map_opt)
map('t', '<M-L>', '<C-\\><C-N><C-w>l', map_opt)
map('t', '<M-Q>', '<C-\\><C-N><Cmd>close<CR>', map_opt)
map('t', '<M-q>', '<C-\\><C-N>', map_opt)
-- Newline above/below current position (cannot work in terminal)
map('i', '<C-CR>', '<Esc>o', map_opt)
map('i', '<S-CR>', '<Esc>O', map_opt)
-- Copy/Paste/Cut
-- map('', '<C-v>', '"+p', map_opt)
-- map('v', '<C-c>', '"+y', map_opt)
-- map('i', '<C-v>', '<C-r>+', map_opt)
-- map('v', '<C-x>', '"+x', map_opt)
-- Disable all <*-MiddleMouse>
map('', '<MiddleMouse>', '<Nop>', map_opt)
map('i', '<MiddleMouse>', '<Nop>', map_opt)
map('', '<2-MiddleMouse>', '<Nop>', map_opt)
map('i', '<2-MiddleMouse>', '<Nop>', map_opt)
map('', '<3-MiddleMouse>', '<Nop>', map_opt)
map('i', '<3-MiddleMouse>', '<Nop>', map_opt)
map('', '<4-MiddleMouse>', '<Nop>', map_opt)
map('i', '<4-MiddleMouse>', '<Nop>', map_opt)
-- Quit to normal mode
-- map('n', '<C-space>', '<Esc>', map_opt)
-- map('!', '<C-space>', '<Esc>', map_opt)
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
vim.cmd([[
function! MaximizeToggle() abort
    if exists('g:GuiLoaded')
        call GuiWindowMaximized(1-g:GuiWindowMaximized)
    endif
endfunction
]])
map('', '<F11>', '<Cmd>call MaximizeToggle()<CR>', map_opt)
map('i', '<F11>', '<Cmd>call MaximizeToggle()<CR>', map_opt)
map('t', '<F11>', '<Cmd>call MaximizeToggle()<CR>', map_opt)
-- Quickly quit
map('n', 'qq', '<Cmd>cclose<CR>', map_opt)
map('n', 'ql', '<Cmd>lclose<CR>', map_opt)
map('n', 'qh', '<Cmd>helpclose<CR>', map_opt)
-- Map meta key
vim.cmd([[
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

---------------
--  Plugins  --
---------------
require('plugins/config/telescope').keybind()
require('plugins/config/asynctasks').keybind()
require('plugins/config/nvim-tree').keybind()
