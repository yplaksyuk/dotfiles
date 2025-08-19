local lspconfig = require("lspconfig")

-- Key mappings for LSP (optional but recommended)
--[[
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  local buf_map = vim.keymap.set
  buf_map('n', 'gd', vim.lsp.buf.definition, opts)
  buf_map('n', 'K', vim.lsp.buf.hover, opts)
  buf_map('n', 'gr', vim.lsp.buf.references, opts)
  buf_map('n', 'gi', vim.lsp.buf.implementation, opts)
  buf_map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  buf_map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  buf_map('n', '[d', vim.diagnostic.goto_prev, opts)
  buf_map('n', ']d', vim.diagnostic.goto_next, opts)
  buf_map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
end
]]--

vim.diagnostic.config({
  virtual_text = true,   -- show inline errors
  signs = false,          -- show gutter symbols
  update_in_insert = false,
  underline = true,
  severity_sort = false,
})

lspconfig.clangd.setup{
  --on_attach = on_attach,
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
}

lspconfig.lua_ls.setup{
  --on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = {'vim'} },  -- recognize `vim` global
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    }
  }
}

lspconfig.ts_ls.setup{
  --on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
}
--[[
lspconfig.tsserver.setup{
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  cmd = { "typescript-language-server", "--stdio" }
}
]]--
