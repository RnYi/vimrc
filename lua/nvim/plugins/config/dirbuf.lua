local M = {}

M.trash_file = function ()
  local path = require('dirbuf').get_cursor_path()
  vim.fn.execute('!trash '..path)
  vim.fn.execute('e!')
end

M.keybind = function ()
  vim.keymap.set('n', '<Leader>e', '<Cmd>tabnew|Dirbuf<CR>')
end

M.setup = function ()
  require('dirbuf').setup {
    hash_first = false,
    sort_order = 'directories_first',
    write_cmd = 'DirbufSync -confirm'
  }
  vim.cmd [[
  augroup Dirbuf
    autocmd!
    autocmd FileType dirbuf set nolist
    autocmd FileType dirbuf nnoremap <buffer><nowait> q <Cmd>close<CR>
    autocmd FileType dirbuf nnoremap <buffer> <C-t> <Cmd>lua require('dirbuf').enter('tabedit')<CR>
    autocmd FileType dirbuf nnoremap <buffer> <C-x> <Cmd>lua require('dirbuf').enter('split')<CR>
    autocmd FileType dirbuf nnoremap <buffer> <C-v> <Cmd>lua require('dirbuf').enter('vsplit')<CR>
    autocmd FileType dirbuf nnoremap <buffer> <M-d> <Cmd>lua require('nvim.plugins.config.dirbuf').trash_file()<CR>
  augroup END
  ]]
end

return M
