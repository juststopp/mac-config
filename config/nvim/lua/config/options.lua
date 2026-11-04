local o = vim.opt

-- Affichage
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.termguicolors = true
o.showmode = false -- le mode est affiché par lualine
o.laststatus = 3 -- une seule barre de statut globale
o.pumheight = 12
o.winborder = "rounded" -- bordures arrondies pour toutes les fenêtres flottantes
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
o.fillchars = { eob = " ", fold = " ", foldopen = "", foldclose = "", foldsep = " " }
o.scrolloff = 8
o.sidescrolloff = 8
o.smoothscroll = true
o.wrap = false
o.linebreak = true
o.breakindent = true

-- Édition
o.mouse = "a"
o.clipboard = "unnamedplus" -- partage le presse-papier macOS
o.undofile = true -- historique d'annulation conservé entre les sessions
o.confirm = true
o.virtualedit = "block"
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.shiftround = true
o.smartindent = true

-- Recherche
o.ignorecase = true
o.smartcase = true
o.inccommand = "split" -- aperçu en direct des :s/…/…/
o.grepprg = "rg --vimgrep"

-- Fenêtres
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"

-- Repli du code (treesitter), tout ouvert par défaut
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldtext = ""
o.foldlevel = 99

-- Divers
o.updatetime = 250
o.timeoutlen = 400
o.completeopt = "menu,menuone,noselect"
o.wildmode = "longest:full,full"
o.jumpoptions = "view"
o.spelllang = { "en", "fr" }
o.shortmess:append({ W = true, I = true, c = true, C = true })

-- Désactive les providers inutilisés (démarrage plus rapide)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
