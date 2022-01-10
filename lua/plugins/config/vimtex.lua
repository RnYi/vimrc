local M = {}

M.setup = function ()
  vim.cmd[[
  " change latexmk build_dir
  let g:vimtex_compiler_latexmk={
    \ 'build_dir' : '.tmp',
    \ 'callback' : 1,
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   ' -shell-escape',
    \   '-interaction=nonstopmode',
    \ ],
    \}

  " it's better to use simple mode for an autocompletion plugin
  let g:vimtex_complete_bib={'simple':1}

  " not open qf on warning
  let g:vimtex_quickfix_open_on_warning=0

  " use mappings defined by vimtex
  let g:vimtex_mappings_override_existing=1

  " disable insert mappings
  let g:vimtex_imaps_enabled=0

  " on Windows, use SumatraPDF as viewer
  if g:sys_uname=='win'
    " otherwise, `:VimtexInfo` will report an error
    let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
  endif

  " communicate to neovim instance via `nvr`
  "   -> pip install neovim-remote
  " configure inverse search for pdf viewer with such a command:
  " in SumatraPDF:
  "   InverseSearchCmdLine = cmd /c for /F %i in ('type %temp%\vimtexserver.txt') do nvr --servername %i -c "normal! zzzv" +"%l" "%f"
  function! s:wrtie_server_name() abort
    let nvim_server_file = (g:sys_uname=='win' ? $TEMP : '/tmp').'/vimtexserver.txt'
    call writefile([v:servername], nvim_server_file)
  endfunction
  " setup server address
  call s:wrtie_server_name()

  " open file in new tab
  let g:vimtex_view_reverse_search_edit_cmd='tabedit'
  " use local texdoc
  let g:vimtex_doc_handlers=['VimTexDocHandler']
  function! VimTexDocHandler(context)
  call vimtex#doc#make_selection(a:context)
  if !empty(a:context.selected)
    execute '!texdoc' a:context.selected '&'
    endif
    return 1
    endfunction
    ]]
end

return M
