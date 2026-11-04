-- ╭──────────────────────────────────────────────────────────────╮
-- │  Neovim · Catppuccin Mocha                                   │
-- │  Géré dans ~/dotfiles/config/nvim (lien vers ~/.config/nvim) │
-- ╰──────────────────────────────────────────────────────────────╯
--
--  lua/config/options.lua   options de l'éditeur
--  lua/config/keymaps.lua   raccourcis généraux (leader = Espace)
--  lua/config/autocmds.lua  automatismes
--  lua/config/lazy.lua      gestionnaire de plugins (lazy.nvim)
--  lua/plugins/*.lua        un fichier par famille de plugins
--
--  Astuce : appuie sur <Espace> et attends, which-key affiche tous
--  les raccourcis disponibles.

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
