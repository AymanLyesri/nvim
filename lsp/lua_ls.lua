-- Native LSP config for lua_ls. See :help lsp-new-config, :help vim.lsp.Config.
-- Enabled automatically by mason-lspconfig (automatic_enable = true).
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
}
