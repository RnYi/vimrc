local M = {}

M.setup = function()
  vim.cmd[[
  let $GTAGSLABEL='native-pygments'
  let $GTAGSCONF=expand('~/.globalrc') " copy from gtags.conf
  let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
  let g:gutentags_ctags_tagfile = '.tags'
  let g:gutentags_modules = ['ctags','gtags_cscope']
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
  ]]
end

return M
