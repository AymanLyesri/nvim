# Neovim Starter (0.12, lazy.nvim, native LSP)

Extensible baseline: general dev, comfortable IDE set, lazy-loaded.

## Layout

- `init.lua` → `config.{options,keymaps,autocmds,lazy}`
- `lua/plugins/*.lua` → one concern per file (add a file = add a feature)
- `lsp/*.lua` → native `vim.lsp.Config` tables, auto-enabled by mason-lspconfig
- `after/ftplugin/*.lua` → per-filetype tweaks

Grounded in `:help lua-guide-config` and `:help lsp-quickstart`.

## First run

1. `nvim` (lazy.nvim clones itself, then install plugins with `:Lazy sync`)
2. `:Mason` to confirm `lua_ls, pyright, ts_ls`
3. `:checkhealth vim.lsp` in a code file

## Extend

- New plugin: copy `lua/plugins/telescope.lua` → edit repo/keys/opts.
- New language server: copy `lsp/pyright.lua` → `lsp/<server>.lua`, add name to `ensure_installed` in `lua/plugins/lsp.lua`.
- New formatter: add entry in `lua/plugins/formatting.lua` → `formatters_by_ft`.
- New keymap: `lua/config/keymaps.lua` with `vim.keymap.set`.

## Keymaps (leader = space)

- `<leader>ff/fg/fb/fh` find/grep/buffers/help, `<leader>e` explorer
- `<leader>cf` format, `<leader>rn/ca` LSP rename/action, `[d/]d` diagnostics
- `gd/K` definition/hover (native LSP defaults + `autocmds.lua`)
