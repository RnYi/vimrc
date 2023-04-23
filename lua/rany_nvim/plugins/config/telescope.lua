local M = {}

-- grep string
M.grep_helper = function ()
  vim.ui.input({prompt='Grep'}, function (search)
    if search then
      require('telescope.builtin').grep_string({search=search,use_regex=true})
    end
  end)
end

-- key bindings
M.keybind = function()
  -- find_files
  vim.keymap.set('n',
  '<Leader>ff',
  [[<Cmd>Telescope find_files<CR>]],
  {desc='Find files'})
  -- live grep
  vim.keymap.set('n',
  '<Leader>fg',
  [[<Cmd>Telescope live_grep<CR>]],
  {desc='Live grep'})
  -- grep string
  vim.keymap.set('n',
  '<Leader>fG',
  [[<Cmd>lua require('rany_nvim.plugins.config.telescope').grep_helper()<CR>]],
  {desc='String grep'})
  -- buffers
  vim.keymap.set('n',
  '<Leader>fb',
  [[<Cmd>Telescope buffers<CR>]],
  {desc='Buffer list'})
  -- quickfix
  vim.keymap.set('n',
  '<Leader>fq',
  [[<Cmd>Telescope quickfix<CR>]],
  {desc='Quickfix list'})
  -- command
  vim.keymap.set('n',
  '<Leader>:',
  [[<Cmd>Telescope commands<CR>]],
  {desc='Commands list'})
end

-- setup
M.setup=function()
  local action_layout = require('telescope.actions.layout')
  local actions = require('telescope.actions')
  local resolver = require('telescope.config.resolve')
  require('telescope').setup {
    defaults = {
      scroll_strategy = 'limit',
      selection_strategy = 'closest',
      dynamic_preview_title = true,
      layout_config = {
        horizontal = {
          preview_width = resolver.resolve_width(0.5)
        }
      },
      mappings = {
        n = {
          ["<M-p>"] = action_layout.toggle_preview,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("cd %s", dir))
          end
        },
        i = {
          ["<M-p>"] = action_layout.toggle_preview,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        no_ignore = false,
        preview = {
          hide_on_startup = true,
        },
      },
      buffers = {
        preview = {
          hide_on_startup = true,
        },
        mappings = {
          n = {
            ['dd'] = 'delete_buffer',
          },
        },
      },
      diagnostics = {
        initial_mode = 'normal',
      },
      lsp_definitions = {
        initial_mode = 'normal',
        jump_type = 'vsplit',
        ignore_filename = false,
      },
      lsp_type_definitions = {
        initial_mode = 'normal',
        jump_type = 'vsplit',
        ignore_filename = false,
      },
    },
  }
end

return M
