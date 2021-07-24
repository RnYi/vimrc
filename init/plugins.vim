if !exists('g:vimrc_home')
    let g:vimrc_home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
    let g:init_home=g:vimrc_home."/init"
endif

" IndentLien
let g:indentLine_enabled=0
noremap <F2> <Cmd>IndentLinesToggle<CR>
inoremap <F2> <Cmd>IndentLinesToggle<CR>

" echodoc
" let g:echodoc_enable_at_startup=1

" vim-lsp-cxx-highlight
" let g:cpp_class_decl_highlight=1
" let g:cpp_class_scope_highlight=1
" let g:cpp_member_variable_highlight=1

" vim-sneak
let g:sneak#label=1
let g:sneak#use_ic_scs=1

" markdown-preview
let g:mkdp_auto_close=0
nmap <Leader>p <Plug>MarkdownPreviewToggle

" vim-commentary
augroup myaug
    autocmd FileType json setlocal commentstring=//%s
augroup END

" fern
let g:fern#smart_cursor="hide"
let g:fern#disable_default_mappings=1
let g:fern#disable_auto_buffer_delete=1
let g:fern#renderer#default#leaf_symbol="| "
let g:fern#renderer#default#expanded_symbol="\u25be "
let g:fern#renderer#default#collapsed_symbol="\u25b8 "
function! s:init_fern() abort
    setlocal nonu
    nmap <buffer><expr>
                \ <Plug>(fern-my-open-or-expand-or-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open)\<Cmd>Fern . -drawer -keep -toggle\<CR>",
                \   "\<Plug>(fern-action-expand:stay)",
                \   "\<Plug>(fern-action-collapse)",
                \ )
    nmap <buffer><silent> e    <Plug>(fern-action-open:tabedit)
    nmap <buffer><silent> o    <Plug>(fern-my-open-or-expand-or-collapse)
    nmap <buffer><silent> go   <Plug>(fern-action-open:edit)<C-w>p
    nmap <buffer><silent> t    <Plug>(fern-action-open:tabedit)
    nmap <buffer><silent> T    <Plug>(fern-action-open:tabedit)gT
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

    nmap <buffer><silent> q <Cmd>quit<CR>

    nmap <buffer><silent> <2-LeftMouse> <Plug>(fern-my-open-or-expand-or-collapse)

endfunction
nnoremap <silent> <Leader>e <Cmd>Fern . -drawer -keep -toggle<CR>
augroup Fern
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

" Ultisnips
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsListSnippets="<C-l>"

" vim-startify
let g:startify_change_cmd='tcd'
let g:startify_session_sort = 1
let g:startify_files_number = 0
let g:startify_change_to_dir = 0
let g:startify_custom_header = []
let g:startify_session_number = 10
let g:startify_update_oldfiles = 1
let g:startify_session_persistence=1
let g:startify_session_delete_buffers=1
let g:startify_lists=[
            \   { 'type': 'sessions',  'header': ['   Sessions']       },
            \   { 'type': 'files',     'header': ['   MRU']            },
            \]

" AsyncTasks
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
inoremap <silent> <F3> <ESC><Cmd>AsyncTask build<CR>
inoremap <silent> <F4> <ESC><Cmd>AsyncTask run<CR>
inoremap <silent> <F5> <ESC><Cmd>AsyncTask debug<CR>
inoremap <silent> <F6> <ESC><Cmd>AsyncTask git-add-commit<CR>
inoremap <silent> <F7> <ESC><Cmd>AsyncTask git-add-commit-push<CR>

" Rainbow Parentheses
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

" lightline
" set noshowmode
let g:lightline={
            \   'colorscheme': 'sonokai',
            \   'active': {
            \       'left': [['mode', 'paste'],['fullpath'],['cocstatus']],
            \       'right' : [['filetype']]
            \   },
            \   'enable': {
            \       'statusline': 1,
            \       'tabline': 0
            \   },
            \   'component_function': {
            \       'mode': 'LightlineMode',
            \       'cocstatus': 'coc#status',
            \       'fullpath': 'LightlinePath',
            \       'filetype': 'LightlineFiletype',
            \   },
            \}

function! LightlineMode()
    return &filetype ==? 'fern' ? 'Fern' :
                \          &filetype ==? 'startify' ? 'Startify' :
                \          lightline#mode()
endfunction

" function! LightlineFilename()
"     let l:filename=expand('%:t')
"     return &filetype ==? 'fern' ? '' :
"                 \          &filetype ==? 'startify' ? '' :
"                 \          &filetype == '' ? '' :
"                 \          winwidth('%') < 40 ? '' : l:filename
" endfunction

function! LightlinePath()
    let l:rlpath=expand('%')
    return &filetype ==? 'fern' ? '' :
                \          &filetype ==? 'startify' ? '' :
                \          &filetype ==? 'help' ? expand('%:t') :
                \          &filetype == '' ? '' :
                \          winwidth('%') < 40 ? '' :
                \          strchars(l:rlpath) < 20 ? l:rlpath : pathshorten(l:rlpath)
endfunction

function! LightlineFiletype()
    return &filetype ==? 'fern' ? '' :
                \          &filetype ==? 'startify' ? '' :
                \          winwidth('%') > 40 ? &filetype : ''
endfunction

" vim-buftabline
set showtabline=2
let g:buftabline_numbers=2
let g:buftabline_indicators=1
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

" coc.nvim
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
nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>qf <Plug>(coc-fix-current)
nmap <Leader>fm <Cmd>call CocAction('format')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-refrences)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K <Cmd>call <SID>show_documentation()<CR>
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
hi CocErrorHighlight gui=undercurl guisp=#ff0000
hi CocWarningHighlight gui=undercurl guisp=#ff922b
hi CocInfoHighlight gui=undercurl guisp=#fab005
hi CocHintHighlight gui=undercurl guisp=#15aabf

" vimtex
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
    let nvim_server_file = has('win32')
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

" vim-textobj-user
let g:vim_textobj_parameter_mapping = 'a'

" vim-xkbswitch
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = g:vimrc_home . '/libxkbswitch64.dll'
let g:XkbSwitchNLayout = 'us'

" vim-shell
let g:shell_mappings_enabled=0
let g:shell_fullscrejen_message=0
let g:shell_fullscreen_items='mT'
let g:shell_fullscreen_always_on_top=0

" nvim-treesitter
if has('nvim')
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed="maintained",
    highlight = {
        enable = true
    },
}
EOF
endif
hi link TSError Normal
