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
  },
}
