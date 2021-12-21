local cmp = require('cmp')
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
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<Esc>'] = cmp.mapping.close(),
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
})
