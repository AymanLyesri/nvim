-- UI: statusline, key hints. No colorscheme: inherit terminal (pywal) colors.
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "auto", globalstatus = true } },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = { { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps" } },
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = { stages = "fade", timeout = 3000 },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
    end,
  },
}
