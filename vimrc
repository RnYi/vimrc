let s:home=fnamemodify(resolve(expand('<sfile>:p')), ':h')
exe "so ".s:home."/vimrc.min"
let &pythonthreedll="python38.dll"
set showmode

