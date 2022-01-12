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
vim.opt.pastetoggle='<F12>'
-- vim.opt.pastetoggle=vim.api.nvim_replace_termcodes('<F12>', true, true, true)
-- Move between lines
map('n', 'H', '^', map_opt)
map('n', 'L', '$', map_opt)
map('x', 'H', '^', map_opt)
map('x', 'L', '$', map_opt)
map('o', 'H', '^', map_opt)
map('o', 'L', '$', map_opt)
map('', 'j', 'gj', map_opt)
map('', 'k', 'gk', map_opt)
map('', '<M-j>', 'j', map_opt)
map('', '<M-k>', 'k', map_opt)
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
map('x', '<M-y>', '"+y', map_opt)
map('', '<M-p>', '"+p', map_opt)
map('i', '<M-p>', '<C-r>+', map_opt)
map('c', '<M-p>', '<C-r>+', map_opt)
map('x', '<M-x>', '"+x', map_opt)
-- Disable all <*-MiddleMouse>
map('', '<MiddleMouse>', '<Nop>', map_opt)
map('i', '<MiddleMouse>', '<Nop>', map_opt)
map('', '<2-MiddleMouse>', '<Nop>', map_opt)
map('i', '<2-MiddleMouse>', '<Nop>', map_opt)
map('', '<3-MiddleMouse>', '<Nop>', map_opt)
map('i', '<3-MiddleMouse>', '<Nop>', map_opt)
map('', '<4-MiddleMouse>', '<Nop>', map_opt)
map('i', '<4-MiddleMouse>', '<Nop>', map_opt)
-- Save/delete buffer
map('n', '<M-s>',  '<Cmd>update<CR>',  map_opt)
map('i', '<M-s>',  '<Esc><Cmd>update<CR>',  map_opt)
map('n', '<M-d>',  '<Cmd>bdelete<CR>',  map_opt)
map('i', '<M-d>',  '<Esc><Cmd>bdelete<CR>',  map_opt)
-- Buffer
map('n', '[b', '<Cmd>bprevious<CR>', map_opt)
map('n', ']b', '<Cmd>bnext<CR>', map_opt)
map('n', '[B', '<Cmd>bfirst<CR>', map_opt)
map('n', ']B', '<Cmd>blast<CR>', map_opt)
-- Tabpage
map('n', '[t', '<Cmd>tabprevious<CR>', map_opt)
map('n', ']t', '<Cmd>tabnext<CR>', map_opt)
map('n', '[T', '<Cmd>tabfirst<CR>', map_opt)
map('n', ']T', '<Cmd>tablast<CR>', map_opt)
map('n', '<M-t>', '<Cmd>tabnew<CR>', map_opt)
map('n', '<M-w>', '<Cmd>tabclose<CR>', map_opt)
map('i', '<M-t>', '<Esc><Cmd>tabnew<CR>', map_opt)
map('i', '<M-w>', '<Esc><Cmd>tabclose<CR>', map_opt)
for i = 1, 10, 1 do -- switch tab
  map('n', '<M-'..(i%10)..'>', '<Cmd>tabnext '..i..'<CR>', map_opt)
  map('i', '<M-'..(i%10)..'>', '<Esc><Cmd>tabnext '..i..'<CR>', map_opt)
end
-- Quickfix
map('n', '[q', '<Cmd>cprevious<CR>', map_opt)
map('n', ']q', '<Cmd>cnext<CR>', map_opt)
map('n', '[Q', '<Cmd>cfirst<CR>', map_opt)
map('n', ']Q', '<Cmd>clast<CR>', map_opt)
-- Location
map('n', '[l', '<Cmd>lprevious<CR>', map_opt)
map('n', ']l', '<Cmd>lnext<CR>', map_opt)
map('n', '[L', '<Cmd>lfirst<CR>', map_opt)
map('n', ']L', '<Cmd>llast<CR>', map_opt)
-- Space
map('n', '[<Space>', '<Cmd>put!=nr2char(10)<CR>', map_opt)
map('n', ']<Space>', '<Cmd>put=nr2char(10)<CR>', map_opt)
-- Toggle window maximized
vim.cmd([[
function! MaximizeToggle() abort
  if exists('g:GuiLoaded')
    call GuiWindowMaximized(1-g:GuiWindowMaximized)
  elseif exists('g:nvui')
    NvuiToggleFullscreen
  endif
endfunction
]])
map('', '<F11>', '<Cmd>call MaximizeToggle()<CR>', map_opt)
map('i', '<F11>', '<Cmd>call MaximizeToggle()<CR>', map_opt)
map('t', '<F11>', '<Cmd>call MaximizeToggle()<CR>', map_opt)
-- Fast quit
map('n', 'q', '<Nop>', map_opt)
map('x', 'q', '<Nop>', map_opt)
map('n', 'Q', '<Nop>', map_opt)
map('n', 'qf', '<Cmd>cclose<CR>', map_opt)
map('n', 'ql', '<Cmd>lclose<CR>', map_opt)
map('n', 'qh', '<Cmd>helpclose<CR>', map_opt)
map('n', 'qa', '<Cmd>qa<CR>', map_opt)
-- Open terminal in a tab
map('n', '<M-=>', '<Cmd>tabnew|terminal<CR>', map_opt)
map('i', '<M-=>', '<Esc><Cmd>tabnew|terminal<CR>', map_opt)
-- Single leader key does nothing
map('n', '<Leader>', '<Nop>', map_opt)
-- Double leader key clear highlight of searching
map('n', '<Leader><Leader>', '<Cmd>nohl<CR>', map_opt)

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
require('plugins/config/indent-blankline').keybind()
require('plugins/config/hop').keybind()
require('plugins/config/fugitive').keybind()
