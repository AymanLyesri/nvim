# AGENTS.md — /home/ayman/.config/nvim

Neovim (>=0.12) config. `lazy.nvim` for plugins, native `vim.lsp` (no `nvim-lspconfig` setup calls), StyLua formatting.

## Layout

- `init.lua` — entry point. Order matters: `config.options` → `config.keymaps` → `config.autocmds` → `config.floaterm` → `config.lazy`. `mapleader = " "`.
- `lua/config/` — `options.lua`, `keymaps.lua`, `autocmds.lua`, `floaterm.lua`, `lazy.lua` (bootstrap + `require("lazy").setup({ spec = { { import = "plugins" } } })`).
- `lua/plugins/*.lua` — one concern per file. Add a feature = add a file (`telescope`, `explorer`, `treesitter`, `completion`, `lsp`, `formatting`, `git`, `ui`, `tools`, `lazygit`).
- `lsp/*.lua` — native `vim.lsp.Config` tables (`lua_ls`, `pyright`, `ts_ls`). Auto-enabled by `mason-lspconfig` (`automatic_enable = true`).
- `after/ftplugin/*.lua` — per-filetype tweaks.
- `.stylua.toml` — Spaces/2 width, 100 cols, Unix endings, double quotes.

## Conventions for agents

- Prefer `edit` over `write`; keep modules small and self-contained (e.g. `floaterm.lua` is ~50 lines).
- Lua: `vim.opt`, `vim.keymap.set`, `vim.api.nvim_*`. Guard `nvim_list_uis()` (empty in headless) — fall back to `vim.o.columns`/`vim.o.lines`.
- Keymaps use `desc = "..."` always. Global maps in `config/keymaps.lua`; buffer-local maps in `autocmds.lua` (`LspAttach`) or at window creation (see `floaterm.lua`).
- State pattern for toggles: `{ buf = -1, win = -1 }` + `nvim_buf_is_valid` / `nvim_win_is_valid` + `nvim_win_hide` (preserves terminal process).
- Do not add plugin deps for what native API covers (`:help nvim_open_win`, `:help terminal`, `:help lsp-quickstart`).

## Floating terminal (`lua/config/floaterm.lua`)

- `M.state`, `M.open()` (80% centered, `border = "rounded"`, `vim.cmd.term()` only if `buftype ~= "terminal"`), `M.hide()`, `M.toggle()`.
- `:ToggleTerminal`, `n` `<leader>tt` toggle, `t` `<Esc><Esc>` → `<C-\><C-n>` exit-to-Normal, `n` `<Esc>` (buffer-local) hide.

## Extend

- Plugin: copy `lua/plugins/telescope.lua`, edit repo/keys/opts.
- LSP server: copy `lsp/pyright.lua` → `lsp/<name>.lua`, add to `ensure_installed` in `lua/plugins/lsp.lua`.
- Formatter: add entry in `lua/plugins/formatting.lua` → `formatters_by_ft`.
- Keymap: add to `lua/config/keymaps.lua`.

## Verify

- `nvim --headless -l /tmp/opencode/test_floaterm.lua` — API checks (loads `config.floaterm`, state init, `toggle`/`open`, `:ToggleTerminal`, `<leader>t` map).
- `nvim --headless -l /tmp/opencode/test_floaterm_func.lua` — functional toggle open → hide → reopen same buf, `buftype == "terminal"`.
- `nvim --headless -c "luafile <script>" -c "qa"` — smoke-test full init.
- In-app: `nvim`, `:Lazy sync`, `:Mason`, `:checkhealth vim.lsp`.
- No `stylua` binary in PATH here — match `.stylua.toml` manually if editing.
