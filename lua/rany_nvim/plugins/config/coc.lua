local M = {}

M.keybind = function()
    local opts = { silent = true, expr = true }
    -- auto completion
    vim.keymap.set('i', '<C-n>', 'coc#pum#visible()?coc#pum#next(1):"<C-n>"', opts)
    vim.keymap.set('i', '<C-p>', 'coc#pum#visible()?coc#pum#prev(1):"<C-p>"', opts)
    vim.keymap.set('i', '<C-e>', 'coc#pum#visible()?coc#pum#cancel():"<C-e>"', opts)
    vim.keymap.set('i', '<Tab>', 'coc#pum#visible()?coc#pum#confirm():"<Tab>"', opts)
    vim.keymap.set('i', '<C-space>', 'coc#refresh()', opts)
    -- scroll popups
    opts = { silent = true, expr = true, nowait = true }
    vim.keymap.set('n', '<C-d>', 'coc#float#has_scroll()?coc#float#scroll(1):"<C-d>"', opts)
    vim.keymap.set('i', '<C-d>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
    vim.keymap.set('v', '<C-d>', 'coc#float#has_scroll()?coc#float#scroll(1):"<C-d>"', opts)
    vim.keymap.set('n', '<C-u>', 'coc#float#has_scroll()?coc#float#scroll(0):"<C-u>"', opts)
    vim.keymap.set('i', '<C-u>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
    vim.keymap.set('v', '<C-u>', 'coc#float#has_scroll()?coc#float#scroll(0):"<C-u>"', opts)
    -- change codes
    opts = { silent = true }
    vim.keymap.set('n', '<Leader>rn', '<Plug>(coc-rename)', opts)
    vim.keymap.set('n', '<Leader>fm', '<Plug>(coc-format)', opts)
    vim.keymap.set('x', '<Leader>fm', '<Plug>(coc-format-selected)', opts)
    -- symbols
    vim.keymap.set('n', 'gd', '<Cmd>call CocAction("definitionHover")<CR>', opts)
    vim.keymap.set('n', 'gD', '<Plug>(coc-definition)', opts)
    vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', opts)
    vim.keymap.set('n', 'gr', '<Plug>(coc-references)', opts)
    local function show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
            vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
            vim.fn.CocActionAsync('doHover')
        else
            vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
    end

    vim.keymap.set('n', 'K', show_docs, opts)
    vim.keymap.set('n', '<C-k>', '<Cmd>call CocActionAsync("showSignaturehelp")<CR>', opts)
    -- diagnostics
    vim.keymap.set('n', '[d', '<Plug>(coc-diagnostic-prev)', opts)
    vim.keymap.set('n', ']d', '<Plug>(coc-diagnostic-next)', opts)
    vim.keymap.set('n', '[e', '<Plug>(coc-diagnostic-prev-error)', opts)
    vim.keymap.set('n', ']e', '<Plug>(coc-diagnostic-next-error)', opts)
    opts = { silent = true, nowait = true }
    vim.keymap.set('n', '<Leader>dl', '<Cmd>CocList --normal --no-quit diagnostics<CR>', opts)
    -- outline
    vim.keymap.set('n', '<Leader>ol', '<Cmd>CocOutline<CR>', opts)
end

M.setup = function()
    vim.g.coc_config_home = vim.g.vimrc_home
    vim.g.markdown_fenced_languages = { 'vim', 'help', 'css', 'js=javascript' }
    vim.g.coc_global_extensions = { "coc-clangd", "coc-json", "coc-vimlsp", "coc-cmake", "coc-tasks",
        "@yaegassy/coc-pylsp", "coc-html", "coc-ultisnips", "coc-texlab", "coc-sumneko-lua", "coc-toml", "coc-yaml",
        "coc-powershell" }
end

return M
