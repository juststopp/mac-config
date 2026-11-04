-- Treesitter : coloration syntaxique précise, indentation et repli du code
local parsers = {
  "bash", "c", "cpp", "css", "dart", "diff", "dockerfile", "git_config", "git_rebase",
  "gitcommit", "gitignore", "html", "java", "javascript", "jsdoc", "json", "kotlin",
  "lua", "luadoc", "markdown", "markdown_inline", "prisma", "python", "query", "regex",
  "rust", "scss", "sql", "swift", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    -- Active treesitter pour chaque fichier dont le langage est installé
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
