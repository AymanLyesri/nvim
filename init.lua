-- Entry point. Order matters: options -> keymaps -> autocmds -> plugin manager.
-- See :help lua-guide-config (init.lua + lua/ modules loaded with require).
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.floaterm")
require("config.lazy")
