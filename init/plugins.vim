"""""""""""""""
" delimitMate "
"""""""""""""""
if has_key(g:plugs_enabled,'delimitMate')
    let g:delimitMate_expand_cr=2
endif

""""""""""""""
" indentLien "
""""""""""""""
if has_key(g:plugs_enabled,'indentLine')
  let g:indentLine_enabled=1
  let g:indentLine_fileType=['vim', 'python']
  let g:indentLine_fileTypeExclude=['startify', 'vim-plug', 'fern']
  let g:indentLine_bufTypeExclude=['help', 'terminal', 'quickfix']
  noremap <F2> <Cmd>IndentLinesToggle<CR>
  inoremap <F2> <Cmd>IndentLinesToggle<CR>
endif

""""""""""""""""""""""""""""""""
"  vim-cpp-enhanced-highlight  "
""""""""""""""""""""""""""""""""
if has_key(g:plugs_enabled, 'vim-cpp-enhanced-highlight')
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_posix_standard = 1
  let g:cpp_experimental_template_highlight = 1
  let g:cpp_concepts_highlight = 1
endif

"""""""""""""""""""""""""
" markdown-preview.nvim "
"""""""""""""""""""""""""
" 需设置win的脚本执行策略为Bypass
if has_key(g:plugs_enabled,'markdown-preview.nvim')
  let g:mkdp_auto_close=0
  nmap <Leader>p <Plug>MarkdownPreviewToggle
endif

""""""""""""""""""
"  vim-markdown  "
""""""""""""""""""
if has_key(g:plugs_enabled,'vim-markdown')
  nnoremap <silent> <Leader>ml <Cmd>Toc<CR>
  let g:markdown_math = 1
  let g:vim_markdown_toc_autofit = 1
  let g:vim_markdown_edit_url_in = 'tab'
  let g:vim_markdown_folding_disabled = 1
endif

""""""""""""""""""
" vim-commentary "
""""""""""""""""""
if has_key(g:plugs_enabled, 'vim-commentary')
  augroup MyAug
    autocmd FileType json setlocal commentstring=//%s
  augroup END
endif

""""""""""""""""
" vim-sandwich "
""""""""""""""""
if has_key(g:plugs_enabled,'vim-sandwich')
  nmap s <Nop>
  xmap s <Nop>
endif

""""""""""""
" fern.vim "
""""""""""""
if has_key(g:plugs_enabled,'fern.vim')
  let g:fern#hide_cursor=1
  let g:fern#keepalt_on_edit=1
  let g:fern#keepjumps_on_edit=1
  let g:fern#disable_default_mappings=1
  let g:fern#disable_auto_buffer_delete=1
  let g:fern#renderer#default#leaf_symbol="| "
  let g:fern#renderer#default#expanded_symbol="\u25be "
  let g:fern#renderer#default#collapsed_symbol="\u25b8 "

  function! s:init_fern() abort
    setlocal nonu
    setlocal guicursor+=a:blinkon0
    nmap <buffer><expr>
          \ <Plug>(fern-my-open-or-expand-or-collapse)
          \ fern#smart#leaf(
          \   "\<Plug>(fern-action-open) \<Cmd>FernDo close\<CR>",
          \   "\<Plug>(fern-action-expand:stay)",
          \   "\<Plug>(fern-action-collapse)",
          \ )
    nmap <buffer><silent> o    <Plug>(fern-my-open-or-expand-or-collapse)
    nmap <buffer><silent> go   <Plug>(fern-action-open)<C-w>p
    nmap <buffer><silent> i <Plug>(fern-action-open:split)
    nmap <buffer><silent> gi <Plug>(fern-action-open:split)<C-w>p
    nmap <buffer><silent> s <Plug>(fern-action-open:vsplit)
    nmap <buffer><silent> gs <Plug>(fern-action-open:vsplit)<C-w>p
    " nmap <buffer><silent> t    <Plug>(fern-action-open:tabedit)
    " nmap <buffer><silent> T    <Plug>(fern-action-open:tabedit)gT
    nmap <buffer><silent> ma   <Plug>(fern-action-new-path)
    nmap <buffer><silent> mc   <Plug>(fern-action-copy)
    nmap <buffer><silent> md   <Plug>(fern-action-trash)
    nmap <buffer><silent> mm   <Plug>(fern-action-move)
    nmap <buffer><silent> mr   <Plug>(fern-action-rename)

    nmap <buffer><silent> cc   <Plug>(fern-action-clipboard-copy)
    nmap <buffer><silent> cp   <Plug>(fern-action-clipboard-paste)
    nmap <buffer><silent> cm   <Plug>(fern-action-clipboard-move)
    nmap <buffer><silent> cr   <Plug>(fern-action-clipboard-clear)
    nmap <buffer><silent> l    <Plug>(fern-action-enter)
    nmap <buffer><silent> h    <Plug>(fern-action-leave)
    nmap <buffer><silent> r    <Plug>(fern-action-reload)
    nmap <buffer><silent> x    <Plug>(fern-action-collapse)
    nmap <buffer><silent> R  gg<Plug>(fern-action-reload)<C-o>
    nmap <buffer><silent> cd   <Plug>(fern-action-tcd:cursor)
    nmap <buffer><silent> CD <Cmd>Fern . -drawer -keep<CR>

    nmap <buffer><silent> -    <Plug>(fern-action-mark:toggle)
    nmap <buffer><silent> _    <Plug>(fern-action-mark:clear)
    nmap <buffer><silent> I    <Plug>(fern-action-hidden:toggle)

    nmap <buffer><silent> q <Cmd>FernDo close<CR>

    nmap <buffer><silent> <2-LeftMouse> <Plug>(fern-my-open-or-expand-or-collapse)

  endfunction
  nnoremap <silent> <Leader>e <Cmd>Fern . -drawer -toggle -keep<CR>
  augroup Fern
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END
endif

"""""""""""""
" ultisnips "
"""""""""""""
if has_key(g:plugs_enabled,'ultisnips')
  let g:UltiSnipsExpandTrigger="<C-j>"
  let g:UltiSnipsJumpForwardTrigger="<C-j>"
  let g:UltiSnipsJumpBackwardTrigger="<C-k>"
  let g:UltiSnipsListSnippets="<C-l>"
endif

""""""""""""""""
" vim-startify "
""""""""""""""""
if has_key(g:plugs_enabled,'vim-startify')
  let g:startify_change_cmd='tcd'
  let g:startify_session_sort = 1
  let g:startify_files_number = 0
  let g:startify_change_to_dir = 0
  " let g:startify_custom_header = []
  let g:startify_session_number = 10
  let g:startify_update_oldfiles = 1
  let g:startify_session_persistence=1
  let g:startify_session_before_save = ["if exists('g:loaded_fern')|FernDo close|endif","cclose","lclose" ]
let g:startify_lists=[
      \   { 'type': 'sessions',  'header': ['   Sessions']       },
      \   { 'type': 'files',     'header': ['   MRU']            },
      \]
endif

"""""""""""""""""""""""""""""""""
" asynctasks.vim & asyncrun.vim "
"""""""""""""""""""""""""""""""""
if has_key(g:plugs_enabled,'asynctasks.vim') && has_key(g:plugs_enabled,'asyncrun.vim')
  augroup AsyncTasks
    autocmd!
    autocmd BufRead,BufNewFile .tasks set filetype=tasks
    autocmd BufRead,BufNewFile tasks.ini set filetype=tasks
  augroup END
  let g:asyncrun_open=6
  let g:asynctasks_term_pos='right'
  let g:asynctasks_term_reuse=1
  let g:asynctasks_extra_config=[
        \ join([g:vimrc_home,"tasks.ini"],'/'),
        \ ]
  let g:asyncrun_rootmarks=['.root','.project','.git','.hg','.svn','.projections.json']
  let g:asynctasks_template={}
  nnoremap <silent> <F3> <Cmd>AsyncTask build<CR>
  nnoremap <silent> <F4> <Cmd>AsyncTask run<CR>
  nnoremap <silent> <F5> <Cmd>AsyncTask debug<CR>
  nnoremap <silent> <F6> <Cmd>AsyncTask git-add-commit<CR>
  nnoremap <silent> <F7> <Cmd>AsyncTask git-add-commit-push<CR>
  inoremap <silent> <F3> <Esc><Cmd>AsyncTask build<CR>
  inoremap <silent> <F4> <Esc><Cmd>AsyncTask run<CR>
  inoremap <silent> <F5> <Esc><Cmd>AsyncTask debug<CR>
  inoremap <silent> <F6> <Esc><Cmd>AsyncTask git-add-commit<CR>
  inoremap <silent> <F7> <Esc><Cmd>AsyncTask git-add-commit-push<CR>
  nnoremap <silent> <Leader>t :AsyncTask 
endif

"""""""""""""""""
" lightline.vim "
"""""""""""""""""
if has_key(g:plugs_enabled,'lightline.vim')
  set noshowmode
  let g:special_ft_list=['', 'startify', 'qf', 'fern', 'vim-plug', 'help']
  let g:special_buf_list=['nofile', 'quickfix', 'terminal', 'help']
  let g:lightline = {
        \ 'colorscheme': 'gruvbox_material',
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified' ],
        \           ['gutentags'] ],
        \ 'tabline': {
            \ 'left':[['tabs']],
            \ 'right':[]
          \},
        \ 'component': {
          \   'gutentags': "%{gutentags#statusline('[',']')}"
          \}
      \}
  augroup GutentagsLightlineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
  augroup END
endif

""""""""""""
" coc.nvim "
""""""""""""
if has_key(g:plugs_enabled,'coc.nvim')
  let g:coc_config_home=g:vimrc_home
  let g:markdown_fenced_languages= ["vim","help","css", "js=javascript"]
  let g:coc_global_extensions=["coc-clangd","coc-json","coc-vimlsp","coc-cmake","coc-tasks","coc-pyright","coc-html","coc-ultisnips","coc-vimtex","coc-sumneko-lua"]
  " command! -nargs=0 Format :call CocAction('format')
  " command! -nargs=? Fold :call CocAction('fold', f-args)
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  " function! s:check_back_space() abort
  "     let col = col('.') - 1
  "     return !col || getline('.')[col - 1]  =~# '\s'
  " endfunction
  nmap <Leader>rn <Plug>(coc-rename)
  nmap <Leader>qf <Plug>(coc-fix-current)
  nmap <Leader>fm <Plug>(coc-format)
  xmap <Leader>fm <Plug>(coc-format-selected)
  nnoremap <silent><nowait> <Leader>ol  <Cmd>CocList outline<CR>
  nnoremap <silent><nowait> <Leader>dl  <Cmd>CocList diagnostics<CR>
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  nnoremap <silent> K <Cmd>call <SID>show_documentation()<CR>
  " inoremap <silent><expr> <TAB>
  "       \ pumvisible() ? "\<C-n>" :
  "       \ <SID>check_back_space() ? "\<TAB>" :
  "       \ coc#refresh()
  " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
  endif
  " hi CocErrorHighlight gui=undercurl guisp=#ff0000
  " hi CocWarningHighlight gui=undercurl guisp=#ff922b
  " hi CocInfoHighlight gui=undercurl guisp=#fab005
  " hi CocHintHighlight gui=undercurl guisp=#15aabf
  augroup Coc
    autocmd! *
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup END
endif

""""""""""
" vimtex "
""""""""""
if has_key(g:plugs_enabled,'vimtex')
  let g:vimtex_complete_bib = { 'simple': 1 }
  let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : '.tmp',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
          \   '-verbose',
          \   '-file-line-error',
          \   '-synctex=1',
          \   '-interaction=nonstopmode',
          \ ],
          \}

  " not open qf on warning
  let g:vimtex_quickfix_open_on_warning=0

  " on Windows, use SumatraPDF as viewer
  " inverse search must be configured in advanced setting of SumatraPDF:
  " inverseSearchCmdLine = cmd /c start /min "" vim -v --not-a-term -T dumb -c "VimtexInverseSearch %l '%f'"

  " open file in new tab
  let g:vimtex_view_reverse_search_edit_cmd='tabedit'

  " use mappings defined by vimtex
  let g:vimtex_mappings_override_existing=1

  " use local texdoc
  let g:vimtex_doc_handlers = ['TexdocHandler']
  function! TexdocHandler(context)
    call vimtex#doc#make_selection(a:context)
    if !empty(a:context.selected)
      silent execute '!texdoc' a:context.selected '&'
    endif
    return 1
  endfunction
endif

""""""""""""""""""""
" vim-textobj-user "
""""""""""""""""""""
if has_key(g:plugs_enabled,'vim-textobj-user')
  let g:vim_textobj_parameter_mapping = 'a'
endif

"""""""""""""""""
" vim-gutentags "
"""""""""""""""""
if has_key(g:plugs_enabled,'vim-gutentags')
  let $GTAGSLABEL='native-pygments'
  let $GTAGSCONF=expand('~/.globalrc') " copy from gtags.conf
  let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
  let g:gutentags_ctags_tagfile = '.tags'
  let g:gutentags_modules = ['ctags', 'gtags_cscope']
  " tags cache dir
  let s:tags_cache_dir = expand('~/.cache/tags')
  let g:gutentags_cache_dir = s:tags_cache_dir
  if !isdirectory(s:tags_cache_dir)
    silent! call mkdir(s:tags_cache_dir, 'p')
  endif
  " ctags args
  let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
  " only for universal ctags
  let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
  " disable auto load gtags database
  let g:gutentags_auto_add_gtags_cscope = 0
endif

""""""""""""""""""""
"  gutentags_plus  "
""""""""""""""""""""
" key map prefix is <Leader>c
" s: Find this symbol
" g: Find this definition
" d: Find functions called by this function
" c: Find functions calling this function
" t: Find this text string
" e: Find this egrep pattern
" f: Find this file
" i: Find files #including this file
" a: Find places where this symbol is assigned a value
if has_key(g:plugs_enabled,'gutentags_plus')
  let g:gutentags_plus_switch = 1
endif

"""""""""""""
" vista.vim "
"""""""""""""
if has_key(g:plugs_enabled, 'vista.vim')
  let g:vista_echo_cursor=0
  let g:vista_blink=[1,300]
  let g:vista_ignore_kinds=['variable']
  let g:vista_executive_for = { 'markdown' : 'toc' }
  nnoremap <Leader>vv <Cmd>Vista!!<CR>
endif

"""""""""""""""""""
"  vim-xkbswitch  "
"""""""""""""""""""
if has_key(g:plugs_enabled,'vim-xkbswitch')
  let g:XkbSwitchEnabled=1
  if g:sys_uname=='mac'
      let g:XkbSwitchLib=g:vimrc_home."/libInputSourceSwitcher.dylib"
  elseif g:sys_uname=='win'
      let g:XkbSwitchLib=g:vimrc_home."/libxkbswitch64.dll"
  endif
endif
