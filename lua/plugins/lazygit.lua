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
    config = function()
      -- <Esc> must KILL the lazygit job, not just hide the window.
      -- The plugin sets bufhidden=hide, so :q/:close leaves the
      -- lazygit process running and the next <leader>gg spawns a
      -- new instance (orphans pile up in `ps`). :bdelete! wipes the
      -- terminal buffer, which terminates the job.
      -- NOTE: terminal-mode `q` is left to lazygit (clean exit);
      -- these maps only force-kill via Esc (both modes) and `q`
      -- from Normal mode (after <C-\><C-n>).
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("LazyGitKillQuit", { clear = true }),
        pattern = "lazygit",
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true, desc = "Kill lazygit" }
          vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:bdelete!<CR>]], opts)
          vim.keymap.set("n", "<Esc>", "<cmd>bdelete!<CR>", opts)
          vim.keymap.set("n", "q", "<cmd>bdelete!<CR>", opts)
        end,
        desc = "Kill lazygit job on quit",
      })
    end,
  },
}
