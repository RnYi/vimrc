----------------------------
--  Aliases for Nvim API  --
----------------------------
local map = vim.keymap.set
----------------
--  Internal  --
----------------
-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Move between lines
map({ 'n', 'x', 'o' }, 'H', '^')
map({ 'n', 'x', 'o' }, 'L', '$')
map('', 'j', 'gj')
map('', 'k', 'gk')
map('', '<M-j>', 'j')
map('', '<M-k>', 'k')
-- Window operations
if vim.g.nvim_env ~= 'vscode' then
    map('n', '<M-J>', '<C-w>j')
    map('n', '<M-K>', '<C-w>k')
    map('n', '<M-H>', '<C-w>h')
    map('n', '<M-L>', '<C-w>l')
    map('n', '<M-Q>', '<Cmd>close<CR>')
    map('i', '<M-J>', '<Esc><C-w>j')
    map('i', '<M-K>', '<Esc><C-w>k')
    map('i', '<M-H>', '<Esc><C-w>h')
    map('i', '<M-L>', '<Esc><C-w>l')
    map('i', '<M-Q>', '<Cmd>close<CR>')
    map('t', '<M-J>', '<C-\\><C-N><C-w>j')
    map('t', '<M-K>', '<C-\\><C-N><C-w>k')
    map('t', '<M-H>', '<C-\\><C-N><C-w>h')
    map('t', '<M-L>', '<C-\\><C-N><C-w>l')
    map('t', '<M-Q>', '<C-\\><C-N><Cmd>close<CR>')
    map('t', '<M-q>', '<C-\\><C-N>')
end
-- Newline above/below current position (cannot work in terminal)
if vim.g.nvim_env ~= 'vscode' then
    map('i', '<C-CR>', '<Esc>o')
    map('i', '<S-CR>', '<Esc>O')
end
-- Copy/Paste/Cut
map('x', '<M-y>', '"+y')
if vim.g.nvim_env == 'vscode' then
    map({ 'n', 'x' }, '<M-p>', '"+p')
else
    map('', '<M-p>', '"+p')
    map({ 'i', 'c' }, '<M-p>', '<C-r>+')
end
map('x', '<M-x>', '"+x')
-- Select paste text
map({ 'n', 'x' }, 'gp', '`[v`]')
-- Disable all <*-MiddleMouse>
map({ '', 'i' }, '<MiddleMouse>', '<Nop>')
map({ '', 'i' }, '<2-MiddleMouse>', '<Nop>')
map({ '', 'i' }, '<3-MiddleMouse>', '<Nop>')
map({ '', 'i' }, '<4-MiddleMouse>', '<Nop>')
-- Save
if vim.g.nvim_env ~= 'vscode' then
    map({ 'n', 'i' }, '<M-s>', '<Esc><Cmd>update<CR>')
end
-- Buffer
if vim.g.nvim_env ~= 'vscode' then
    map('n', '[b', '<Cmd>bprevious<CR>')
    map('n', ']b', '<Cmd>bnext<CR>')
    map('n', '[B', '<Cmd>bfirst<CR>')
    map('n', ']B', '<Cmd>blast<CR>')
end
-- Tabpage
map('n', '[t', '<Cmd>tabprevious<CR>')
map('n', ']t', '<Cmd>tabnext<CR>')
map('n', '[T', '<Cmd>tabfirst<CR>')
map('n', ']T', '<Cmd>tablast<CR>')
if vim.g.nvim_env ~= 'vscode' then
    map({ 'n', 'i' }, '<M-t>', '<Esc><Cmd>tabnew<CR>')
    for i = 1, 10, 1 do -- switch tab
        map({ 'n', 'i' }, '<M-' .. (i % 10) .. '>', '<Esc><Cmd>tabnext ' .. i .. '<CR>')
    end
end
-- Quickfix
if vim.g.nvim_env ~= 'vscode' then
    map('n', '[q', '<Cmd>cprevious<CR>')
    map('n', ']q', '<Cmd>cnext<CR>')
    map('n', '[Q', '<Cmd>cfirst<CR>')
    map('n', ']Q', '<Cmd>clast<CR>')
    -- Location
    map('n', '[l', '<Cmd>lprevious<CR>')
    map('n', ']l', '<Cmd>lnext<CR>')
    map('n', '[L', '<Cmd>lfirst<CR>')
    map('n', ']L', '<Cmd>llast<CR>')
end
-- Space
map('n', '[<Space>', '<Cmd>put!=nr2char(10)<CR>')
map('n', ']<Space>', '<Cmd>put=nr2char(10)<CR>')
-- Toggle window maximized
if vim.g.nvim_env ~= 'vscode' then
    vim.cmd([[
function! MaximizeToggle() abort
  if exists('g:GuiLoaded')
    call GuiWindowMaximized(1-g:GuiWindowMaximized)
  elseif exists('g:nvui')
    NvuiToggleFullscreen
  endif
endfunction
]]   )
    map({ '', 'i', 't' }, '<F11>', '<Cmd>call MaximizeToggle()<CR>')
end
-- Fast quit

if vim.g.nvim_env ~= 'vscode' then
    map({ 'n', 'x' }, 'q', '<Nop>')
    map('n', 'Q', '<Nop>')
    map('n', 'qf', '<Cmd>cclose<CR>')
    map('n', 'ql', '<Cmd>lclose<CR>')
    map('n', 'qh', '<Cmd>helpclose<CR>')
    map('n', 'qa', '<Cmd>qa<CR>')
    map('n', 'qb', '<Cmd>bdelete<CR>')
    map('n', 'qw', '<Cmd>close<CR>')
end
map('n', 'qt', '<Cmd>tabclose<CR>')
-- Open terminal in a tab
if vim.g.nvim_env ~= 'vscode' then
    map({ 'n', 'i' }, '<M-=>', '<Esc><Cmd>tabnew|terminal<CR>')
end
-- Single leader key does nothing
map('n', '<Leader>', '<Nop>')
-- Double leader key clear highlight of searching
map('n', '<Leader><Leader>', '<Cmd>nohl<CR>')
-- Remap <C-x><C-k>
map('i', '<C-x><C-k>', '<C-x><C-k>')
-- Popup
-- map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], {noremap=true, silent=true, expr=true})
-- map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], {noremap=true, silent=true, expr=true})
-- Map meta key

if vim.g.nvim_env ~= 'vscode' then
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
]]   )
end
---------------
--  Plugins  --
---------------
if vim.g.nvim_env == 'vscode' then
    return
end
local function keybind(name)
    local path = ('rany_nvim.plugins.config.%s'):format(name)
    require(path).keybind()
end

keybind('asynctasks')
keybind('fugitive')
keybind('hop')
keybind('indent-blankline')
keybind('oil')
keybind('telescope')
if vim.g.comp_plug == 'coc' then
    keybind('coc')
end
