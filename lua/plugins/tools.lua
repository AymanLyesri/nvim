-- Auto-install external tools via Mason (runs at startup, before parsers build).
-- Provides the `tree-sitter` CLI that nvim-treesitter needs to compile parsers,
-- so you don't have to `pacman -S tree-sitter-cli` by hand.
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        -- NOTE: no "lazygit" — Mason's registry doesn't carry it.
        -- Install via system package: sudo pacman -S lazygit
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
