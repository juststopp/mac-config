-- Raccourcis généraux. Les raccourcis des plugins sont dans lua/plugins/.
-- Clavier AZERTY : on évite Alt et les crochets pour les raccourcis principaux.
local map = vim.keymap.set

-- Base
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Effacer la surbrillance" })
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Sauvegarder" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Tout quitter" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Plugins (Lazy)" })
map("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason (LSP, formateurs)" })

-- Se déplacer dans les lignes longues comme on les voit
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Recherche centrée à l'écran
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Garder la sélection après une indentation
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Déplacer des lignes (J/K en mode visuel)
map("x", "J", ":m '>+1<cr>gv=gv", { desc = "Descendre la sélection", silent = true })
map("x", "K", ":m '<-2<cr>gv=gv", { desc = "Monter la sélection", silent = true })

-- Fenêtres
map("n", "<C-h>", "<C-w>h", { desc = "Fenêtre de gauche" })
map("n", "<C-j>", "<C-w>j", { desc = "Fenêtre du bas" })
map("n", "<C-k>", "<C-w>k", { desc = "Fenêtre du haut" })
map("n", "<C-l>", "<C-w>l", { desc = "Fenêtre de droite" })
map("n", "<leader>wv", "<C-w>v", { desc = "Diviser verticalement" })
map("n", "<leader>ws", "<C-w>s", { desc = "Diviser horizontalement" })
map("n", "<leader>wd", "<C-w>c", { desc = "Fermer la fenêtre" })
map("n", "<leader>w=", "<C-w>=", { desc = "Égaliser les tailles" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Agrandir (hauteur)" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Réduire (hauteur)" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Réduire (largeur)" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Agrandir (largeur)" })

-- Buffers (fichiers ouverts)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer précédent" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Buffer suivant" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Revenir au buffer précédent" })

-- Diagnostics (équivalents AZERTY de ]d / [d)
map("n", "<leader>xn", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Diagnostic suivant" })
map("n", "<leader>xp", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Diagnostic précédent" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostic de la ligne" })

-- Interrupteurs d'interface
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Retour à la ligne on/off" })
map("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Correcteur on/off" })
map("n", "<leader>ur", "<cmd>set relativenumber!<cr>", { desc = "Numéros relatifs on/off" })
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Diagnostics on/off" })

-- Terminal : Échap deux fois pour revenir en mode normal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Quitter le mode terminal" })
