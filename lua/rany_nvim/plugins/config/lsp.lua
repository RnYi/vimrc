local M = {}
-- Define a function for showing diagnostics on a float window

M.setup = function()
    -- local show_documentation = function()
    --     local t = { ['vim'] = true, ['help'] = true }
    --     if t[vim.bo.filetype] then
    --         vim.api.nvim_command('h ' .. vim.fn.expand('<cword>'))
    --     else
    --         vim.lsp.buf.hover()
    --     end
    --
    -- end

    ---------------------
    -- Autocmd for lsp --
    ---------------------
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            local opts = { buffer = ev.buf }
            -- keymaps
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>fm', vim.lsp.buf.format, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist, opts)
            -- Show diagnostics
            vim.api.nvim_create_autocmd('CursorHold', {
                group = 'UserLspConfig',
                callback = vim.diagnostic.open_float
            })
        end
    })

    ----------------------------
    -- Configs for diagnostic --
    ----------------------------
    vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        signs = true,
        severity_sort = true,
        float = {
            focus = false,
            focusable = false,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
            scope = 'cursor',
            source = 'if_many', -- show source in diagnostic popup window
        }
    })
    -- Change border of documentation hover window
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --     focus = false,
    --     focusable = false,
    -- })

    -------------------------
    -- Signs of diagnostic --
    -------------------------
    vim.fn.sign_define("DiagnosticSignError",
        { text = ">>", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",
        { text = ">>", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
        { text = ">>", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
        { text = ">>", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })

    ----------------------------
    -- Setup language servers --
    ----------------------------
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')
    -- cpp
    lspconfig.clangd.setup {
        capabilities = capabilities,
    }
    -- lua
    --     -> https://github.com/sumneko/lua-language-server/releases
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')
    lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua
                    -- you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    -- path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized
                -- but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
    -- cmake
    --     -> https://github.com/regen100/cmake-language-server
    --     -> pip install cmake-language-server
    lspconfig.cmake.setup {
        capabilities = capabilities,
    }
    -- python
    --     -> https://github.com/microsoft/pyright
    --     -> pip install pyright
    lspconfig.pyright.setup {
        capabilities = capabilities,
    }
    -- viml
    --    -> npm install -g vim-language-server
    lspconfig.vimls.setup {
        capabilities = capabilities,
        initializationOptions={
            isNeovim=true,
        },
    }
end
-- return M
return M
