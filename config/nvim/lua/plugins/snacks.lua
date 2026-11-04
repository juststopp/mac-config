-- snacks.nvim : page d'accueil, recherche (fichiers, texte, LSP…), explorateur,
-- notifications, terminal flottant, lazygit intégré, guides d'indentation…
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true }, -- allège nvim sur les très gros fichiers
    quickfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = "󰱼 ", key = "f", desc = "Chercher un fichier", action = ":lua Snacks.picker.smart()" },
          { icon = "󰝒 ", key = "n", desc = "Nouveau fichier", action = ":ene | startinsert" },
          { icon = "󱎸 ", key = "g", desc = "Chercher du texte", action = ":lua Snacks.picker.grep()" },
          { icon = "󰋚 ", key = "r", desc = "Fichiers récents", action = ":lua Snacks.picker.recent()" },
          { icon = "󰉓 ", key = "p", desc = "Projets", action = ":lua Snacks.picker.projects()" },
          { icon = "󰒓 ", key = "c", desc = "Config Neovim", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
          { icon = "󰒲 ", key = "l", desc = "Plugins", action = ":Lazy" },
          { icon = "󰈆 ", key = "q", desc = "Quitter", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { icon = "󱔗 ", title = "Fichiers récents (ce dossier)", section = "recent_files", cwd = true, limit = 5, indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    explorer = { enabled = true, replace_netrw = false }, -- les dossiers s'ouvrent avec Oil
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
      enabled = true,
      ui_select = true,
      sources = { files = { hidden = true }, grep = { hidden = true }, explorer = { hidden = true } },
    },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true }, -- surligne les autres occurrences du symbole
    lazygit = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    -- Les plus utiles
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Chercher un fichier" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Chercher du texte (projet)" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Fichiers ouverts" },
    { "<leader>e", function() Snacks.explorer() end, desc = "Arborescence" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Historique des commandes" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notifications" },

    -- Fichiers
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Fichiers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Récents" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projets" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config Neovim" },
    { "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Renommer le fichier" },

    -- Recherche
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Mot sous le curseur", mode = { "n", "x" } },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Lignes du fichier" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Aide" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Raccourcis" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "Symboles (fichier)" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Symboles (projet)" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Historique d'annulation" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Reprendre la recherche" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Changer de thème" },

    -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Fichiers modifiés" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Historique" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Historique du fichier" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Ouvrir sur GitHub", mode = { "n", "x" } },

    -- Buffers
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Fermer le buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Fermer les autres buffers" },

    -- Terminal flottant
    { "<leader>tt", function() Snacks.terminal() end, desc = "Terminal" },
    { "<c-/>", function() Snacks.terminal() end, desc = "Terminal", mode = { "n", "t" } },

    -- Divers
    { "<leader>z", function() Snacks.zen() end, desc = "Mode zen" },
    { "<leader>.", function() Snacks.scratch() end, desc = "Note brouillon" },
  },
}
