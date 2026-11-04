# dotfiles · Catppuccin Mocha

Toute la configuration du Mac au même endroit : terminal, shell, Neovim, widgets, réglages macOS.
Les fichiers de `~` (`~/.zshrc`, `~/.config/nvim`…) sont des **liens** vers ce dossier : modifier ici = modifier partout.

## Réinstaller sur un Mac neuf

```sh
git clone https://github.com/juststopp/mac-config.git ~/dotfiles && ~/dotfiles/install.sh
```

`install.sh` installe les apps du `Brewfile`, crée les liens (en sauvegardant l'existant dans `~/.dotfiles-backup/`), installe les plugins et thèmes, puis applique `macos.sh`. Il peut être relancé sans risque (`--no-brew` pour sauter Homebrew).

## Contenu

| Dossier | Rôle |
|---|---|
| `zsh/` | `.zshrc` (plugins, alias, fzf) et `.zprofile` (PATH) — sans Oh My Zsh |
| `config/nvim/` | Neovim écrit de zéro : lazy.nvim, LSP, treesitter, snacks… |
| `config/ghostty/` | Terminal Ghostty |
| `config/starship.toml` | Prompt |
| `config/zen/` | Zen Browser : thème Catppuccin Mocha (`chrome/`) et réglages (`user.js`, mots de passe confiés à Apple Mots de passe) |
| `ubersicht/` | Widgets du bureau (lus directement ici par Übersicht) : horloge, progression du temps, serveurs de dev, failles exploitées (CISA KEV), stats système |
| `scripts/` | `sysstats`, `devservers`, `kev` : données des widgets (utilisables aussi dans le terminal) |
| `Brewfile` | Toutes les apps et outils (`brew bundle dump --force` pour le mettre à jour) |
| `macos.sh` | Bureau sans icônes, Dock auto, captures dans `~/Pictures/Screenshots`, fond d'écran |

## Aide-mémoire

### Terminal

| Commande / touche | Effet |
|---|---|
| `Ctrl+R` | Rechercher dans l'historique (fzf) |
| `Ctrl+T` | Insérer un fichier (avec aperçu) |
| `Tab` | Complétion dans fzf, avec aperçu des dossiers |
| `→` | Accepter la suggestion grise |
| `z <nom>` / `cd <nom>` | Sauter vers un dossier déjà visité |
| `y` | Explorateur de fichiers yazi (le terminal suit le dossier en sortant) |
| `l`, `ll`, `lt` | Lister (détails, arbre) avec icônes et statut git |
| `lg` | lazygit |
| `btop` | Moniteur système |
| `tldr <cmd>` | Exemples rapides d'une commande |
| `mac-clean` | Vider les caches npm / Homebrew / Xcode |
| `brewup` | Tout mettre à jour |
| `py2` | Shell Python 2 dans Docker (dossier courant monté) |
| `nano`, `vim`, `v` | Ouvrent Neovim |
| `Cmd+Échap` | Terminal déroulant Ghostty, depuis n'importe quelle app |
| `Cmd+D` / `Cmd+Maj+D` | Diviser Ghostty à droite / en bas |

### Neovim (leader = `Espace`)

Appuie sur `Espace` et attends : la liste complète s'affiche.

| Touche | Effet |
|---|---|
| `Espace Espace` | Chercher un fichier |
| `Espace /` | Chercher du texte dans le projet |
| `Espace ,` | Fichiers ouverts |
| `Espace e` | Arborescence |
| `-` | Ouvrir le dossier comme un fichier (Oil) : renommer / supprimer en éditant, puis `:w` |
| `s` + 2 lettres | Sauter n'importe où à l'écran |
| `gd` / `gr` / `K` | Définition / références / documentation |
| `Espace ca` / `Espace cr` | Actions de code / renommer le symbole |
| `Espace cf` | Formater (auto à la sauvegarde ; `Espace uf` pour couper) |
| `Espace xx` | Liste des erreurs · `Espace xn` / `xp` : erreur suivante / précédente |
| `Espace gg` | lazygit |
| `Espace hn` / `hp` / `hs` | Modif git suivante / précédente / stager |
| `Espace tt` | Terminal flottant |
| `Shift+h` / `Shift+l` | Fichier ouvert précédent / suivant |
| `Ctrl+s` | Sauvegarder |
| `gsa"` / `gsd"` / `gsr"'` | Entourer de guillemets / les enlever / les remplacer |
| `Espace l` / `Espace cm` | Plugins (Lazy) / outils LSP (Mason) |

L'ancienne config (jdhao/nvim-config) est sauvegardée dans `~/.dotfiles-backup/`.
