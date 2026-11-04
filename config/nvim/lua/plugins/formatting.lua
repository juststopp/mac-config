-- Formatage automatique à la sauvegarde (conform.nvim)
--   <leader>cf : formater maintenant · <leader>uf : activer / désactiver le formatage auto
local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  init = function() vim.g.autoformat = true end,
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true }) end, mode = { "n", "x" }, desc = "Formater" },
    {
      "<leader>uf",
      function()
        vim.g.autoformat = not vim.g.autoformat
        vim.notify("Formatage auto " .. (vim.g.autoformat and "activé" or "désactivé"))
      end,
      desc = "Formatage auto on/off",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      css = prettier,
      scss = prettier,
      html = prettier,
      json = prettier,
      jsonc = prettier,
      yaml = prettier,
      markdown = prettier,
      graphql = prettier,
      sh = { "shfmt" },
      bash = { "shfmt" },
      rust = { "rustfmt" },
    },
    default_format_opts = { lsp_format = "fallback" }, -- sinon : formateur du serveur LSP (Dart, Swift, C…)
    format_on_save = function()
      if vim.g.autoformat then return { timeout_ms = 1000 } end
    end,
  },
}
