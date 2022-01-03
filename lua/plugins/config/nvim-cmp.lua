local M = {}

M.setup = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  cmp.setup ({
    -- MUST specify a snippet engine
    snippet = {
      expand = function (args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    sources = {
      { name = 'path' },
      { name = 'buffer' },
      { name = 'cmdline' },
      { name = 'nvim_lsp'},
      { name = 'nvim_lua'},
      { name = 'ultisnips'},
    },
    completion = {
      completeopt = 'menu,noselect'
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = {
          nvim_lsp = "[LSP]",
          ultisnips = "[US]",
          nvim_lua = "[Lua]",
          path = "[Path]",
          buffer = "[Buffer]",
          latex_symbols = "[Latex]"
        },
      }),
    },
  })
end

return M
