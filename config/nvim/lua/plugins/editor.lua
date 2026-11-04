-- Outils d'édition
return {
  -- mini.nvim : icônes, paires automatiques, objets de texte, surround
  {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    config = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
      require("mini.pairs").setup() -- ferme automatiquement ( [ { " '
      require("mini.ai").setup({ n_lines = 500 }) -- objets de texte enrichis : vif, vaa, ci"…
      require("mini.surround").setup({ -- gsa" ajoute des guillemets, gsd" les enlève, gsr"' les remplace
        mappings = {
          add = "gsa", delete = "gsd", find = "gsf", find_left = "gsF",
          highlight = "gsh", replace = "gsr", update_n_lines = "gsn",
        },
      })
    end,
  },

  -- Oil : « - » ouvre le dossier courant comme un fichier texte qu'on édite
  -- (renommer = modifier la ligne, supprimer = effacer la ligne, puis :w)
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      keymaps = { ["q"] = "actions.close" },
    },
    keys = { { "-", "<cmd>Oil<cr>", desc = "Ouvrir le dossier (Oil)" } },
  },

  -- Flash : « s » puis 2 lettres pour sauter n'importe où à l'écran
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = { modes = { search = { enabled = false } } },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Sauter (Flash)" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Sélection Treesitter" },
    },
  },

  -- Git dans la marge
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" }, change = { text = "▎" }, delete = { text = "▁" },
        topdelete = { text = "▔" }, changedelete = { text = "▎" }, untracked = { text = "▎" },
      },
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc }) end
        map("<leader>hn", function() gs.nav_hunk("next") end, "Modif suivante")
        map("<leader>hp", function() gs.nav_hunk("prev") end, "Modif précédente")
        map("]h", function() gs.nav_hunk("next") end, "Modif suivante")
        map("[h", function() gs.nav_hunk("prev") end, "Modif précédente")
        map("<leader>hv", gs.preview_hunk_inline, "Voir la modif")
        map("<leader>hs", gs.stage_hunk, "Stager la modif")
        map("<leader>hr", gs.reset_hunk, "Annuler la modif")
        map("<leader>hS", gs.stage_buffer, "Stager le fichier")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame de la ligne")
        map("<leader>hd", gs.diffthis, "Diff du fichier")
        map("<leader>ub", gs.toggle_current_line_blame, "Blame en ligne on/off")
      end,
    },
  },

  -- Liste propre des erreurs / avertissements
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (projet)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (fichier)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Liste quickfix" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Plan du fichier" },
    },
  },

  -- TODO / FIXME / NOTE colorés et cherchables
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "TODO / FIXME" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODO (liste)" },
    },
  },
}
