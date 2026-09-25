-- LSP: native vim.lsp.config + vim.lsp.enable() (see :help lsp-quickstart).
-- Servers install via Mason; configs live in lsp/*.lua.
return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    keys = { { "<leader>m", "<cmd>Mason<CR>", desc = "Open Mason" } },
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "ts_ls" },
      automatic_enable = true, -- calls vim.lsp.enable() for installed servers
    },
  },
}
