local M = {}

M.keybind = function ()
  vim.keymap.set('n', '<Leader>e', '<Cmd>tabnew|Dirbuf<CR>')
end

M.setup = function ()
  require('dirbuf').setup {
    hash_first = false,
    sort_order = 'directories_first'
  }
  vim.cmd [[
  augroup Dirbuf
    autocmd!
    autocmd FileType dirbuf set nolist
    autocmd FileType dirbuf nnoremap <buffer><nowait> q <Cmd>close<CR>
    autocmd FileType dirbuf nnoremap <buffer> <C-t> <Cmd>lua require('dirbuf').enter('tabedit')<CR>
  augroup END
  ]]
end

return M
