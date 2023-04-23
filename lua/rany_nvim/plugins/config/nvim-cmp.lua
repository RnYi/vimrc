local M = {}

M.setup = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup({
        -- MUST specify a snippet engine
        snippet = {
            expand = function(args)
                require('snippy').expand_snippet(args.body)
                -- vim.fn["UltiSnips#Anon"](args.body)
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-Space'] = cmp.mapping.complete(),
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'snippy' },
            { name = 'buffer' },
            { name = 'path' },
        }),
        -- completion = {
        --   completeopt = 'menu,noselect'
        -- },
        formatting = {
            format = lspkind.cmp_format({
                mode='symbol_text',
                maxwidth=50,
                ellipsis_char='...',
                -- menu = {
                --     nvim_lsp = "[LSP]",
                --     snippy="[SNP]",
                --     ultisnips = "[US]",
                --     nvim_lua = "[Lua]",
                --     path = "[P]",
                --     buffer = "[B]",
                --     omni = "[O]"
                -- },
            }),
        },
    })
    -- filetype
    cmp.setup.filetype('lua', {
        sources = cmp.config.sources({
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
            { name = 'snippy' },
            { name = 'buffer' },
            { name = 'path' },
        })
    })
    -- cmdline
    cmp.setup.cmdline({ '/', '?' }, {
        sources = {
            { name = 'buffer' }
        }
    })
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
        })
    })
end

return M
