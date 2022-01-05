local M = {}

M.setup = function ()
  vim.cmd[[
  " global coc-settings.json is in vimrc home
  let g:coc_config_home=g:vimrc_home
  let g:markdown_fenced_languages= ["vim","help","css", "js=javascript"]
  " coc extensions must be installed
  let g:coc_global_extensions=["coc-clangd","coc-json","coc-vimlsp","coc-cmake","coc-tasks","coc-pyright","coc-html","coc-ultisnips","coc-vimtex","coc-sumneko-lua"]
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  " use <Tab> and <S-Tab> to navigate in popup
  inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  " rename
  nmap <Leader>rn <Plug>(coc-rename)
  " autofix
  nmap <Leader>qf <Plug>(coc-fix-current)
  " format
  nmap <Leader>fm <Plug>(coc-format)
  xmap <Leader>fm <Plug>(coc-format-selected)
  " outlile
  nnoremap <silent><nowait> <Leader>ol  <Cmd>CocList outline<CR>
  " diagnostics list
  nnoremap <silent><nowait> <Leader>dl  <Cmd>CocList diagnostics<CR>
  " navigate
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  " scroll popups
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
  " show documentation
  nnoremap <silent> K <Cmd>call <SID>show_documentation()<CR>
  " confirm selection
  inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

  augroup Coc
    autocmd! *
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup END
  ]]
end

return M
