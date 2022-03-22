local M = {}

M.setup = function ()
  vim.cmd[[
  " global coc-settings.json is in vimrc home
  let g:coc_config_home=g:vimrc_home
  let g:markdown_fenced_languages= ["vim","help","css", "js=javascript"]
  " coc extensions must be installed
  let g:coc_global_extensions=["coc-clangd","coc-json","coc-vimlsp","coc-cmake","coc-tasks","@yaegassy/coc-pylsp","coc-html","coc-ultisnips","coc-texlab","coc-sumneko-lua","coc-toml","coc-yaml","coc-powershell","coc-markdown-preview-enhanced","coc-webview"]
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  " rename
  nmap <Leader>rn <Plug>(coc-rename)
  " autofix
  nmap <Leader>qf <Plug>(coc-fix-current)
  " format
  nmap <Leader>fm <Plug>(coc-format)
  xmap <Leader>fm <Plug>(coc-format-selected)
  " code action
  nmap <Leader>ac <Plug>(coc-codeaction-cursor)
  nmap <Leader>aC <Plug>(coc-codeaction)
  xmap <Leader>ac <Plug>(coc-codeaction-selected)
  " textobjects
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)
  " outlile
  nnoremap <silent><nowait> <Leader>ol  <Cmd>CocOutline<CR>
  " diagnostics
  nnoremap <silent><nowait> <Leader>dl  <Cmd>CocList --normal --no-quit diagnostics<CR>
  " navigate
  nmap <silent> gd <Cmd>call CocAction('definitionHover')<CR>
  nmap <silent> gD <Plug>(coc-definition)
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
  inoremap <silent><expr> <C-y> pumvisible() ? coc#_select_confirm() : "\<C-y>"
  " if exists('*complete_info')
  "     inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
  " else
  "   inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
  " endif

  augroup Coc
    autocmd!
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd FileType markdown nnoremap <buffer> <Leader>mp <Cmd>CocCommand markdown-preview-enhanced.openPreview<CR>
    autocmd FileType markdown nnoremap <buffer> <Leader>mo <Cmd>CocCommand markdown-preview-enhanced.createTOC<CR>
  augroup END
  ]]
end

return M
