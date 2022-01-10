let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"
set pastetoggle=<F12>
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L $

noremap <M-j> gj
noremap <M-k> gk

nnoremap <M-J> <C-w>j
nnoremap <M-K> <C-w>k
nnoremap <M-H> <C-w>h
nnoremap <M-L> <C-w>l
nnoremap <M-Q> <Cmd>close<CR>
inoremap <M-J> <Esc><C-w>j
inoremap <M-K> <Esc><C-w>k
inoremap <M-H> <Esc><C-w>h
inoremap <M-L> <Esc><C-w>l
inoremap <M-Q> <Cmd>close<CR>
tnoremap <M-J> <C-\><C-N><C-w>j
tnoremap <M-K> <C-\><C-N><C-w>k
tnoremap <M-H> <C-\><C-N><C-w>h
tnoremap <M-L> <C-\><C-N><C-w>l
tnoremap <M-Q> <C-\><C-N><Cmd>close<CR>
tnoremap <M-q> <C-\><C-N>
tnoremap <C-v> <C-w>"+

cnoremap <M-h> <Left>
cnoremap <M-l> <Right>

inoremap <C-CR> <Esc>o
inoremap <S-CR> <Esc>O

noremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>

nnoremap <silent> <M-s> <Cmd>update<CR>
inoremap <silent> <M-s> <Esc><Cmd>update<CR>
nnoremap <silent> <M-d> <Cmd>bdelete<CR>
inoremap <silent> <M-d> <Esc><Cmd>bdelete<CR>

nnoremap <silent> [b <Cmd>bprevious<CR>
nnoremap <silent> ]b <Cmd>bnext<CR>
nnoremap <silent> [B <Cmd>bfirst<CR>
nnoremap <silent> ]B <Cmd>blast<CR>
nnoremap <silent> [q <Cmd>cprevious<CR>
nnoremap <silent> ]q <Cmd>cnext<CR>
nnoremap <silent> [Q <Cmd>cfirst<CR>
nnoremap <silent> ]Q <Cmd>clast<CR>
nnoremap <silent> [l <Cmd>lprevious<CR>
nnoremap <silent> ]l <Cmd>lnext<CR>
nnoremap <silent> [L <Cmd>lfirst<CR>
nnoremap <silent> ]L <Cmd>llast<CR>
nnoremap <silent> [<Space> <Cmd>put!=nr2char(10)<CR>
nnoremap <silent> ]<Space> <Cmd>put=nr2char(10)<CR>
" Tab
nnoremap <silent> [t <Cmd>tabprevious<CR>
nnoremap <silent> ]t <Cmd>tabnext<CR>
nnoremap <silent> [T <Cmd>tabfirst<CR>
nnoremap <silent> ]T <Cmd>tablast<CR>
nnoremap <silent> <M-t> <Cmd>tabnew<CR>
inoremap <silent> <M-t> <Esc><Cmd>tabnew<CR>
nnoremap <silent> <M-w> <Cmd>tabclose<CR>
inoremap <silent> <M-w> <Esc><Cmd>tabclose<CR>
function s:switch_tab_keymap()
  for i in range(10)
    exec 'nnoremap <M-'.(i%10).'> <Cmd>tabnext '.i.'<CR>'
    exec 'inoremap <M-'.(i%10).'> <Esc><Cmd>tabnext '.i.'<CR>'
  endfor
endfunction
call s:switch_tab_keymap()

" Quickly quit
nnoremap q <Nop>
xnoremap q <Nop>
nnoremap Q <Nop>
nnoremap <silent> qf <Cmd>cclose<CR>
nnoremap <silent> ql <Cmd>lclose<CR>
nnoremap <silent> qh <Cmd>helpclose<CR>
nnoremap <silent> qa <Cmd>qa<CR>
" Open terminal
nnoremap <silent> <M-=> <Cmd>tabnew <bar> terminal<CR>
inoremap <silent> <M-=> <Esc><Cmd>tabnew <bar> terminal<CR>
" Single leader key does nothing
nnoremap <Leader> <Nop>
" nohl
nnoremap <Leader><Leader> <cmd>nohl<CR>

let g:wmctrl_exec=executable('wmctrl')
function! MaximizeToggle() abort
  " neovim-qt
  if exists('g:GuiLoaded')
    call GuiWindowMaximized(1-g:GuiWindowMaximized)
    " linux gvim
  elseif has('gui_running') && g:wmctrl_exec
    call system("wmctrl -ir ".v:windowid." -b toggle,maximized_vert,maximized_horz")
    redraw!
  endif
endfunction

noremap <F11> <Cmd>call MaximizeToggle()<CR>
inoremap <F11> <Cmd>call MaximizeToggle()<CR>
tnoremap <F11> <Cmd>call MaximizeToggle()<CR>

" Grep
function s:bufferlist() " get all listed buffers
  let res = getbufinfo({'listed':1})
  let bufs = []
  for item in res
    call add(bufs, item.name)
  endfor
  return bufs
endfunction

function GrepOnBuffers(str)
  exec 'vimgrep/'.a:str.'/g '.join(s:bufferlist())
  " highlight matches
  call clearmatches()
  silent call matchadd('Search', a:str)
endfunction
nnoremap <M-f> <Cmd>call GrepOnBuffers(expand('<cword>'))
      \ <bar> copen
      \ <bar> wincmd p<CR>

" map meta key
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
