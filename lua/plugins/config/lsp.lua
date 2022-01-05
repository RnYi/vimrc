local M = {}
-- Define a function for showing diagnostics on a float window
M.show_diagnostics = function()
  local opts = {
    focus=false,
    focusable=false,
    scope = 'cursor',
    source = 'always',  -- show source in diagnostic popup window
  }
  vim.diagnostic.open_float(nil, opts)
end

M.show_documentation = function ()
  local t = {['vim']=true,['help']=true}
  if t[vim.bo.filetype] then
    vim.api.nvim_command('h '..vim.fn.expand('<cword>'))
  else
    vim.lsp.buf.hover()
  end
end

M.setup = function()
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local custom_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', [[<cmd>lua require('plugins/config/lsp').show_documentation()<CR>]], opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('x', '<space>fm', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

    -- Show diagnostics with float window
    vim.cmd([[
    autocmd CursorHold <buffer> lua require('plugins/config/lsp').show_diagnostics()
    ]])

    -- Highlight the variable under current cursor
    if client.resolved_capabilities.document_highlight then
      vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
      augroup LspDocumentHighlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved,InsertEnter <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]])
    end
  end
  -- Global config for diagnostic
  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = true,
    severity_sort = true,
  })
  -- Change border of documentation hover window
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    focus=false,
    focusable=false,
  })
  -- Change diagnostic signs
  vim.fn.sign_define("DiagnosticSignError",
  {text = ">>", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError"})
  vim.fn.sign_define("DiagnosticSignWarn",
  {text = ">>", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn"})
  vim.fn.sign_define("DiagnosticSignInfo",
  {text = ">>", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo"})
  vim.fn.sign_define("DiagnosticSignHint",
  {text = ">>", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint"})

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- Setup language servers
  local lspconfig = require('lspconfig')
  -- Clangd
  lspconfig.clangd.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
  -- Lua
  --     -> https://github.com/sumneko/lua-language-server/releases
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')
  lspconfig.sumneko_lua.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua
          -- you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        -- Do not send telemetry data containing a randomized
        -- but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
  -- CMake
  --     -> https://github.com/regen100/cmake-language-server
  --     -> pip install cmake-language-server
  lspconfig.cmake.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
  -- Python
  --     -> https://github.com/microsoft/pyright
  --     -> pip install pyright
  lspconfig.pyright.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
  -- VimL
  --    -> npm install -g vim-language-server
  lspconfig.vimls.setup{
    on_attach = custom_attach,
    capabilities = capabilities,
  }

end
-- return M
return M
