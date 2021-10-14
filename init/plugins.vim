""""""""""""""
" indentLien "
""""""""""""""
if HasPlug('indentLine')
    let g:indentLine_enabled=0
    noremap <F2> <Cmd>IndentLinesToggle<CR>
    inoremap <F2> <Cmd>IndentLinesToggle<CR>
endif

""""""""""""""""""""""""""""""""
"  vim-cpp-enhanced-highlight  "
""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

"""""""""""""""""""""""""
" markdown-preview.nvim "
"""""""""""""""""""""""""
" 需设置win的脚本执行策略为Bypass
if HasPlug('markdown-preview.nvim')
    let g:mkdp_auto_close=0
    nmap <Leader>p <Plug>MarkdownPreviewToggle
endif

""""""""""""""""""
" vim-commentary "
""""""""""""""""""
augroup MyAug
    autocmd FileType json setlocal commentstring=//%s
augroup END

""""""""""""""""
" vim-sandwich "
""""""""""""""""
if HasPlug('vim-sandwich')
    nmap s <Nop>
    xmap s <Nop>
endif

""""""""""""
" fern.vim "
""""""""""""
if HasPlug('fern.vim')
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
if HasPlug('ultisnips')
    let g:UltiSnipsExpandTrigger="<C-j>"
    let g:UltiSnipsJumpForwardTrigger="<C-j>"
    let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    let g:UltiSnipsListSnippets="<C-l>"
endif

""""""""""""""""
" vim-startify "
""""""""""""""""
if HasPlug('vim-startify')
    let g:startify_change_cmd='tcd'
    let g:startify_session_sort = 1
    let g:startify_files_number = 0
    let g:startify_change_to_dir = 0
    " let g:startify_custom_header = []
    let g:startify_session_number = 10
    let g:startify_update_oldfiles = 1
    let g:startify_session_persistence=1
    let g:startify_session_before_save = ["if exists('g:loaded_fern')|FernDo close|endif","cclose" ]
    let g:startify_lists=[
                \   { 'type': 'sessions',  'header': ['   Sessions']       },
                \   { 'type': 'files',     'header': ['   MRU']            },
                \]
endif

"""""""""""""""""""""""""""""""""
" asynctasks.vim & asyncrun.vim "
"""""""""""""""""""""""""""""""""
if HasPlug('asynctasks.vim') && HasPlug('asyncrun.vim')
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
endif

"""""""""""""""""""""""
" Rainbow Parentheses "
"""""""""""""""""""""""
" let g:rainbow_active=1
" let g:rainbow_conf={
"             \   'operators': '_,_',
"             \   'parentheses': ['start=/(/ end=/)/ fold',
"             \                   'start=/\[/ end=/\]/ fold',
"             \                   'start=/{/ end=/}/ fold'],
"             \   'separately': {
"             \       '*': {},
"             \       'nerdtree':0,
"             \       'tex': {
"             \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
"             \       },
"             \       'lisp': {
"             \           'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
"             \       },
"             \       'vim': {
"             \           'parentheses':
"             \               ['start=/(/ end=/)/',
"             \                'start=/\[/ end=/\]/',
"             \                'start=/{/ end=/}/ fold',
"             \                'start=/(/ end=/)/ containedin=vimFuncBody',
"             \                'start=/\[/ end=/\]/ containedin=vimFuncBody',
"             \                'start=/{/ end=/}/ fold containedin=vimFuncBody'],
"             \       },
"             \       'html': {
"             \           'parentheses': ['start=/\v\((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ ])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'=`]*))?)*\/ end=#/\z1# fold'],
"             \       },
"             \       'css': 0,
"             \   }
"             \}

"""""""""""""""""
" lightline.vim "
"""""""""""""""""
if HasPlug('lightline.vim')
    set noshowmode
    let g:special_ft_list=['', 'startify', 'qf', 'fern', 'vim-plug', 'help']
    let g:special_buf_list=['', 'nofile', 'quickfix', 'terminal', 'help']
    let g:lightline={
                \   'colorscheme': 'edge',
                \   'active': {
                    \       'left': [ ['mode', 'paste'],
                    \                 ['path', 'readonly'],
                    \                 ['cocstatus', 'gutstatus'] ],
                    \       'right' : [ ['lineinfo'],
                    \                   ['percent'],
                    \                   ['fileformat', 'fileencoding', 'filetype']],
                \   },
                \   'inactive' : {
                    \        'left':[ ['path'] ],
                    \        'right':[ ['lineinfo'], ['percent'],]
                \   },
                \   'component_expand' : {
                    \       'lineinfo' : 'LightlineLineinfo',
                    \       'percent' : 'LightlinePercent',
                \   },
                \  'component_function_visible_condition' : {
                    \       'path' : "(&filetype=='fern')||(index(g:special_ft_list,&filetype)<0)",
                    \       'fileformat' : "(&filetype=='help')||(&buftype!='terminal'&&index(g:special_ft_list,&filetype)<0)",
                    \       'fileencoding' : "(&filetype=='help')||(&buftype!='terminal'&&index(g:special_ft_list,&filetype)<0)",
                    \       'filetype' : "(&filetype=='help')||(&buftype!='terminal'&&index(g:special_ft_list,&filetype)<0)",
                    \       'lineinfo' : "(&filetype!='fern')&&(&filtype!='startify')",
                    \       'percent' : "(&filetype!='fern')&&(&filtype!='startify')",
                \ },
                \   'enable': {
                    \       'statusline': 1,
                    \       'tabline': 0
                \   },
                        \   'component_function' : {
                            \       'cocstatus' : 'coc#status',
                            \       'gutstatus' : 'LightlineGut',
                            \       'mode' : 'LightlineMode',
                            \       'path' : 'LightlinePath',
                            \       'fileformat' : 'LightlineFm',
                            \       'fileencoding' : 'LightlineFec',
                            \       'filetype' : 'LightlineFt',
                        \   },
                                    \}

    function! LightlineMode()
        return &filetype ==? 'fern' ? 'Fern' :
                    \          &filetype ==? 'startify' ? 'Startify' :
                    \          &buftype ==? 'quickfix' ? "Quickfix List" :
                    \          lightline#mode()
    endfunction

    function! LightlinePath()
        let l:fern_path_pat='\Vfern://\.\+/file:///\zs\.\+\ze;keep$\$'
        return &filetype ==? 'fern' ? matchstr(expand('%:p'),l:fern_path_pat) :
                    \          &buftype ==? 'help' ? expand('%:t') : 
                    \          index(g:special_ft_list,&filetype)>=0 ? '' : expand('%')
        " \          winwidth('%') < 40 ? '' :
        " \          strchars(l:rlpath) < 20 ? l:rlpath : pathshorten(l:rlpath)
    endfunction

    function! LightlineLineinfo()
        return ((&filetype!='fern') && (&filetype!='startify'))?'%3l:%-2c':''
    endfunction

    function! LightlinePercent()
        return ((&filetype!='fern') && (&filetype!='startify'))?'%3p%%':''
    endfunction

    function! LightlineFm()
        return (&filetype=='help')||(&buftype!='terminal'&&index(g:special_ft_list,&filetype)<0) ? &fileformat : ''
    endfunction

    function! LightlineFec()
        return (&filetype=='help')||(&buftype!='terminal'&&index(g:special_ft_list,&filetype)<0) ? &fileencoding : ''
    endfunction

    function! LightlineFt()
        return (&filetype=='help')||(&buftype!='terminal'&&index(g:special_ft_list,&filetype)<0) ? &filetype : ''
    endfunction

    function! LightlineGut()
        return exists('g:loaded_gutentags') ? gutentags#statusline('[',']'):''
    endfunction

    augroup Lightline
        autocmd!
        if exists('g:loaded_gutentags')
            autocmd User GutentagsUpdating call lightline#update()
            autocmd User GutentagsUpdated call lightline#update()
        endif
        autocmd FileType startify call lightline#update()
    augroup END
endif

""""""""""""""""""
" vim-buftabline "
""""""""""""""""""
if HasPlug('vim-buftabline')
    let g:buftabline_show=2
    let g:buftabline_numbers=2
    let g:buftabline_indicators=1
    " let g:buftabline_separators=1
    nmap <Leader>1 <Plug>BufTabLine.Go(1)
    nmap <Leader>2 <Plug>BufTabLine.Go(2)
    nmap <Leader>3 <Plug>BufTabLine.Go(3)
    nmap <Leader>4 <Plug>BufTabLine.Go(4)
    nmap <Leader>5 <Plug>BufTabLine.Go(5)
    nmap <Leader>6 <Plug>BufTabLine.Go(6)
    nmap <Leader>7 <Plug>BufTabLine.Go(7)
    nmap <Leader>8 <Plug>BufTabLine.Go(8)
    nmap <Leader>9 <Plug>BufTabLine.Go(9)
    nmap <Leader>0 <Plug>BufTabLine.Go(10)
    " hi! link BufTabLineCurrent PmenuSel
    " hi! link BufTabLineActive TabLineSel
endif

""""""""""""""""""""
"  vim-bufferline  "
""""""""""""""""""""
if HasPlug('vim-bufferline')
    let g:bufferline_rotate = 2
endif

""""""""""""
" coc.nvim "
""""""""""""
if HasPlug('coc.nvim')
    let g:coc_config_home=g:vimrc_home
    let g:markdown_fenced_languages= ["vim","help","css", "js=javascript"]
    let g:coc_global_extensions=["coc-clangd","coc-json","coc-vimlsp","coc-cmake","coc-tasks","coc-pyright","coc-html","coc-ultisnips","coc-vimtex"]
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
    nnoremap <silent><nowait> <Leader>ds  <Cmd>CocList diagnostics<CR>
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
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
if HasPlug('vimtex')
    let g:vimtex_quickfix_mode = 0
    let g:vimtex_compiler_progname='nvr'
    let g:vimtex_complete_bib = { 'simple': 1 }
    let g:vimtex_compiler_latexmk = {
                \ 'build_dir' : '.tmp',
                \ 'callback' : 1,
                \ 'continuous' : 0,
                \ 'executable' : 'latexmk',
                \ 'hooks' : [],
                \ 'options' : [
                    \   '-pv',
                    \   '-verbose',
                    \   '-file-line-error',
                    \   '-synctex=1',
                    \   '-interaction=nonstopmode',
                    \ ],
                    \}
    let g:vimtex_doc_handlers = ['TexdocHandler']
    function! TexdocHandler(context)
        call vimtex#doc#make_selection(a:context)
        if !empty(a:context.selected)
            silent execute '!texdoc' a:context.selected '&'
        endif
        return 1
    endfunction
    function s:vimtex_keymap() abort
        nmap <buffer><silent> K <plug>(vimtex-doc-package)
        noremap <buffer><silent> <LocalLeader>lw <Cmd>VimtexCountWords!<CR><CR>
    endfunction
    function s:set_servername()
        let nvim_server_file = g:sys_uname=='windows'
                    \ ? $TEMP . "/curnvimserver.txt"
                    \ : "/tmp/curnvimserver.txt"
        call system(printf("echo %s > %s", v:servername, nvim_server_file))
    endfunction
    function s:vimtex_config() abort
        call s:vimtex_keymap()
        call s:set_servername()
    endfunction
    augroup VimTex
        autocmd!
        autocmd FileType tex call s:vimtex_config()
    augroup END
endif

""""""""""""""""""""
" vim-textobj-user "
""""""""""""""""""""
if HasPlug('vim-textobj-user')
    let g:vim_textobj_parameter_mapping = 'a'
endif

"""""""""""""""""
" vim-gutentags "
"""""""""""""""""
if HasPlug('vim-gutentags')
    let $GTAGSLABEL='native-pygments'
    let $GTAGSCONF=expand('~/.globalrc') " copy from gtags.conf
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    let g:gutentags_ctags_tagfile = '.tags'
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif
    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif
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
    " file list
    " let g:gutentags_file_list_command={
    "             \ 'markers': {
    "                 \ '.git': 'git ls-files',
    "                 \ },
    "             \}
    " .gutgtags can be used for gtags options, '-f' can specify file list
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
let g:gutentags_plus_switch = 1

"""""""""""""
" vim-shell "
"""""""""""""
" let g:shell_mappings_enabled=0
" let g:shell_fullscrejen_message=0
" let g:shell_fullscreen_items='mT'
" let g:shell_fullscreen_always_on_top=0

"""""""""""""""""""
" nvim-treesitter "
"""""""""""""""""""
" if HasPlug('nvim-treesitter')
" lua << EOF
"     require'nvim-treesitter.configs'.setup {
"     ensure_installed="maintained",
"     highlight = {
"     enable = true
"     },
"     }
" EOF
" endif
