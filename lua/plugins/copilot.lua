-- Copilot: inline ghost-text completions + commit message generation.
-- Ghost text only (no blink.cmp source) so it never fights blink.
-- Requires Node >= 20 and `:Copilot auth` once.
-- Commits stay in lazygit (<leader>gg): <leader>gC generates the message
-- in a Neovim float, yank it, paste into lazygit. No lazygit config touched.
return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          accept_word = "<M-w>",
          accept_line = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-/>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        lazygit = false,
        TelescopePrompt = false,
        ["*"] = true,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      -- Notify once shortly after startup if not signed in.
      -- Silent when authenticated; retries while the LSP client starts.
      local attempts = 0
      local function check_auth()
        attempts = attempts + 1
        local ok_c, c = pcall(require, "copilot.client")
        local ok_api, api = pcall(require, "copilot.api")
        if not (ok_c and ok_api) then
          return
        end
        if not c.get() then
          if attempts < 3 then
            vim.defer_fn(check_auth, 5000)
          end
          return
        end
        c.use_client(function(client)
          api.check_status(client, { options = { localChecksOnly = true } }, function(err, status)
            if err then
              return
            end
            if not (status and status.user) then
              vim.schedule(function()
                vim.notify("[Copilot] Not signed in — run :Copilot auth", vim.log.levels.WARN)
              end)
            end
          end)
        end)
      end
      vim.defer_fn(check_auth, 3000)
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat", "CopilotChatCommit", "CopilotChatExplain" },
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
    build = "make tiktoken",
    opts = {},
    keys = {
      { "<leader>gC", "<cmd>CopilotChatCommit<CR>", desc = "Generate commit message" },
      { "<leader>ge", "<cmd>CopilotChatExplain<CR>", mode = { "n", "v" }, desc = "Explain with Copilot" },
    },
  },
}
