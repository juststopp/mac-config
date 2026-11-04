-- Langages spécifiques
return {
  -- Markdown rendu joliment directement dans le fichier
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {},
  },

  -- Ferme / renomme automatiquement les balises HTML et JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Flutter / Dart : LSP, guides de widgets, :FlutterRun, :FlutterDevices…
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = "dart",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      widget_guides = { enabled = true },
      closing_tags = { highlight = "Comment", prefix = "// " },
      lsp = { color = { enabled = true } },
    },
  },
}
