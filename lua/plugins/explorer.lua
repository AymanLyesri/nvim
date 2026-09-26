-- File explorer: neo-tree. <leader>e toggles.
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle explorer" },
      { "<leader>o", "<cmd>Neotree focus<CR>", desc = "Focus explorer" },
    },
    opts = {
      window = { position = "right" },
      filesystem = {
        follow_current_file = { enabled = true },
        -- VSCode-style: show EVERYTHING, never hide or dim.
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {},
          never_show = {},
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("NeotreeAutoOpen", { clear = true }),
        callback = function()
          local argc = vim.fn.argc(-1)
          if argc == 0 then
            vim.cmd("Neotree show")
          elseif argc == 1 then
            local arg = vim.fn.argv(0) --[[@as string]]
            if vim.fn.isdirectory(arg) == 1 then
              vim.cmd("bd")
              vim.cmd("Neotree show dir=" .. vim.fn.fnameescape(arg))
            end
          end
        end,
        desc = "Auto-open neo-tree on startup (no args or directory)",
      })
    end,
  },
}
