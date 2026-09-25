-- Treesitter: syntax, indent, textobjects.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    dependencies = { "mason-org/mason.nvim" }, -- mason bin/ (tree-sitter CLI) on PATH first
    opts = {},
    config = function()
      -- mason-tool-installer provides the CLI async on first run; skip the
      -- build instead of erroring, parsers compile on the next restart.
      if vim.fn.executable("tree-sitter") == 0 then
        vim.notify(
          "tree-sitter CLI not found (installing via Mason) — parsers will build after restart. Or: sudo pacman -S tree-sitter-cli",
          vim.log.levels.WARN
        )
        return
      end
      -- Parsers to always have. Add yours with :TSInstall <lang>.
      local ensure = { "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript", "tsx", "json", "yaml", "toml", "markdown", "markdown_inline", "qmljs" }
      require("nvim-treesitter").install(ensure)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            pcall(vim.treesitter.start, ev.buf)
          end
        end,
      })
    end,
  },
}
