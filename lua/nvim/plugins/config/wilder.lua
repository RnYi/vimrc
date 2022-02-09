local M = {}

M.setup = function ()
  vim.cmd[[
  call wilder#setup({
    \  'modes': [':'],
    \  'next_key': '<Tab>',
    \  'previous_key': '<S-Tab>',
    \  'accept_key': '<C-y>',
    \  'reject_key': '<C-e>'
    \  })
  call wilder#set_option('pipeline', [
    \  wilder#branch(
    \    wilder#python_file_finder_pipeline({
    \      'file_command': ['fd', '-I', '-H', '-tf'],
    \      'dir_command': ['fd','-I', '-H', '-td'],
    \      'filters': ['fuzzy_filter', 'difflib_sorter'],
    \    }),
    \    wilder#cmdline_pipeline({
    \      'language': 'python',
    \      'fuzzy': 1,
    \    }),
    \    wilder#python_search_pipeline({
    \      'pattern': wilder#python_fuzzy_pattern(),
    \      'sorter': wilder#python_difflib_sorter(),
    \      'engine': 're',
    \    }),
    \  ),
    \ ])
  let s:popupmenu_renderer = wilder#popupmenu_renderer({
    \  'highlighter': wilder#basic_highlighter(),
    \  'left': [' ', wilder#popupmenu_devicons(),],
    \  'right': [' ', wilder#popupmenu_scrollbar()]
    \  })
  call wilder#set_option('renderer', wilder#renderer_mux({
    \  ':': s:popupmenu_renderer,
    \  }))
  ]]
end

return M
