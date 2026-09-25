-- lazygit TUI. <leader>gg opens it in a floating terminal.
-- Requires the `lazygit` binary: sudo pacman -S lazygit
return {
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open lazygit" },
      { "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", desc = "lazygit for current file" },
    },
  },
}
