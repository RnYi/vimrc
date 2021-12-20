-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,noselect'

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
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
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
})
