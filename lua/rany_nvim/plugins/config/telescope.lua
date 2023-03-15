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
  local map=vim.keymap.set
  local map_opt={noremap=true, silent=true}
  -- find_files
  map('n',
  '<Leader>ff',
  [[<Cmd>Telescope find_files<CR>]],
  map_opt)
  -- live grep
  map('n',
  '<Leader>fg',
  [[<Cmd>Telescope live_grep<CR>]],
  map_opt)
  -- grep string
  map('n',
  '<Leader>fG',
  [[<Cmd>lua require('nvim.plugins.config.telescope').grep_helper()<CR>]],
  map_opt)
  -- buffers
  map('n',
  '<Leader>fb',
  [[<Cmd>Telescope buffers<CR>]],
  map_opt)
  -- quickfix
  map('n',
  '<Leader>fq',
  [[<Cmd>Telescope quickfix<CR>]],
  map_opt)
  -- command
  map('n',
  '<Leader>:',
  [[<Cmd>Telescope commands<CR>]],
  map_opt)

  if CompPlug~='coc' then
    -- lsp_definitions
    map('n',
    'gd',
    [[<Cmd>Telescope lsp_definitions<CR>]],
    map_opt)
    -- lsp_references
    map('n',
    'gr',
    [[<Cmd>Telescope lsp_references<CR>]],
    map_opt)
    -- lsp_type_definitions
    map('n',
    'gy',
    [[<Cmd>Telescope lsp_type_definitions<CR>]],
    map_opt)
    -- diagnostics in current buffer
    map('n',
    '<Leader>dl',
    [[<Cmd>Telescope diagnostics bufnr=0<CR>]],
    map_opt)
    -- diagnostics of all buffers
    map('n',
    '<Leader>dL',
    [[<Cmd>Telescope diagnostics<CR>]],
    map_opt)
    -- document symbols in current buffer
    map('n',
    '<Leader>ds',
    [[<Cmd>Telescope lsp_document_symbols<CR>]],
    map_opt)
  end
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
