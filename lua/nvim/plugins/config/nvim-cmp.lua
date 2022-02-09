local M = {}

M.setup = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  cmp.setup ({
    -- MUST specify a snippet engine
    snippet = {
      expand = function (args)
        require('snippy').expand_snippet(args.body)
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
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
      ['<CR>'] = cmp.mapping.confirm(),
    },
    sources = {
      { name = 'nvim_lsp'},
      { name = 'snippy'},
      { name = 'buffer' },
      { name = 'path' },
    },
    completion = {
      completeopt = 'menu,noselect'
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = {
          nvim_lsp = "[LSP]",
          snippy = "[SNP]",
          nvim_lua = "[Lua]",
          path = "[Path]",
          buffer = "[Buffer]",
          omni = "[OMNI]"
        },
      }),
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      {
        name = 'path',
        option = {
          trailing_slash = true
        }
      }
    }, {
      { name = 'cmdline', keyword_pattern=[=[[^[:blank:]\!]*]=]}
    })
  })

  -- config sources for specific filetye
  vim.cmd[[
  augroup NvimCmp
    autocmd!
    autocmd FileType tex
    \  lua require('cmp').setup.buffer{
      \  sources={
        \    {name='omni'},
        \    {name='snippy'},
        \    {name='buffer'},
        \    {name='path'},
        \  }
        \ }
    autocmd FileType lua
    \  lua require('cmp').setup.buffer{
      \  sources={
        \    {name='nvim_lsp'},
        \    {name='snippy'},
        \    {name='nvim_lua'},
        \    {name='buffer'},
        \    {name='path'},
        \  }
        \ }
  augroup END
  ]]
end

return M