----------------------------
--  Aliases for Nvim API  --
----------------------------
local map=vim.keymap.set
local map_opt={noremap=true, silent=true}

----------------
--  Internal  --
----------------
-- Leader key
vim.g.mapleader=' '
vim.g.maplocalleader=' '
-- Move between lines
map({'n', 'x', 'o'}, 'H', '^', map_opt)
map({'n', 'x', 'o'}, 'L', '$', map_opt)
map('', 'j', 'gj', map_opt)
map('', 'k', 'gk', map_opt)
-- Disable all <*-MiddleMouse>
map({'', 'i'}, '<MiddleMouse>', '<Nop>', map_opt)
map({'', 'i'}, '<2-MiddleMouse>', '<Nop>', map_opt)
map({'', 'i'}, '<3-MiddleMouse>', '<Nop>', map_opt)
map({'', 'i'}, '<4-MiddleMouse>', '<Nop>', map_opt)
-- Tabpage
map('n', '[t', '<Cmd>Tabprevious<CR>', map_opt)
map('n', ']t', '<Cmd>Tabnext<CR>', map_opt)
map('n', '[T', '<Cmd>Tabfirst<CR>', map_opt)
map('n', ']T', '<Cmd>Tablast<CR>', map_opt)
map('n', 'qt',  '<Cmd>Tabclose<CR>',  map_opt)
-- Space
map('n', '[<Space>', '<Cmd>put!=nr2char(10)<CR>', map_opt)
map('n', ']<Space>', '<Cmd>put=nr2char(10)<CR>', map_opt)
-- Single leader key does nothing
map('n', '<Leader>', '<Nop>', map_opt)
-- Double leader key clear highlight of searching
map('n', '<Leader><Leader>', '<Cmd>nohl<CR>', map_opt)
-- Comment
map({'n','x','o'},'gc','<Plug>VSCodeCommentary',map_opt)
map('n','gcc','<Plug>VSCodeCommentaryLine',map_opt)
-- map('x','gC',"<Cmd>call VSCodeNotifyVisual('editor.action.blockComment',1)<CR>",map_opt)
