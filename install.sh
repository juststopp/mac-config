#!/usr/bin/env bash
# ╭──────────────────────────────────────────────────────────────╮
# │  Installe tout l'environnement (apps, terminal, nvim, bureau) │
# │  Relançable sans risque. Après une réinstallation de macOS :  │
# │    git clone <ton-repo> ~/dotfiles && ~/dotfiles/install.sh   │
# │  Sans réinstaller les apps : ./install.sh --no-brew           │
# ╰──────────────────────────────────────────────────────────────╯
set -euo pipefail
DOT="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y-%m-%d_%H%M%S)"

step() { printf '\n\033[1;35m▶ %s\033[0m\n' "$1"; }

# link <chemin dans dotfiles> <destination> : sauvegarde l'existant puis crée le lien
link() {
  local src="$DOT/$1" dst="$2"
  if [[ -L $dst && $(readlink "$dst") == "$src" ]]; then echo "  · ${dst/#$HOME/~}"; return; fi
  if [[ -e $dst || -L $dst ]]; then
    mkdir -p "$BACKUP/$(dirname "${dst#$HOME/}")"
    mv "$dst" "$BACKUP/${dst#$HOME/}"
    echo "  ↪ ancien fichier sauvegardé dans ${BACKUP/#$HOME/~}"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "  ✓ ${dst/#$HOME/~}"
}

step "Homebrew"
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
if [[ ${1:-} != --no-brew ]]; then brew bundle --file="$DOT/Brewfile"; else echo "  (ignoré)"; fi

step "Liens vers les fichiers de config"
link zsh/zshrc                ~/.zshrc
link zsh/zprofile             ~/.zprofile
link config/nvim              ~/.config/nvim
link config/ghostty           ~/.config/ghostty
link config/starship.toml     ~/.config/starship.toml
link config/bat               ~/.config/bat
link config/btop              ~/.config/btop
link config/yazi              ~/.config/yazi
link config/lazygit/config.yml "$HOME/Library/Application Support/lazygit/config.yml"

step "Git (delta, nvim comme éditeur)"
git config --global --get-all include.path 2>/dev/null | grep -q "dotfiles/git/gitconfig" \
  || git config --global --add include.path "~/dotfiles/git/gitconfig"
echo "  ✓ ~/.gitconfig inclut ~/dotfiles/git/gitconfig"

step "Plugins zsh"
mkdir -p ~/.local/share/zsh
[[ -d ~/.local/share/zsh/fzf-tab ]] || git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.local/share/zsh/fzf-tab
echo "  ✓ fzf-tab"

step "Thèmes"
bat cache --build >/dev/null && echo "  ✓ bat"
[[ -d $DOT/config/yazi/flavors/catppuccin-mocha.yazi ]] || ya pkg add yazi-rs/flavors:catppuccin-mocha
echo "  ✓ yazi"
if [[ ! -f $DOT/wallpaper/catppuccin-mocha.png ]]; then
  rsvg-convert "$DOT/wallpaper/catppuccin-mocha.svg" -o "$DOT/wallpaper/catppuccin-mocha.png"
fi
echo "  ✓ fond d'écran"

step "Übersicht (widgets lus directement dans ~/dotfiles/ubersicht)"
# Übersicht stocke son dossier de widgets comme une URL archivée (NSKeyedArchiver)
pkill -f "Übersicht.app/Contents" 2>/dev/null || true
WDIR_HEX=$(osascript -l JavaScript -e "ObjC.import('Foundation'); \$.NSKeyedArchiver.archivedDataWithRootObject(\$.NSURL.fileURLWithPathIsDirectory('$DOT/ubersicht', true)).base64EncodedStringWithOptions(0).js" | base64 -d | xxd -p | tr -d '\n')
defaults write tracesOf.Uebersicht widgetDirectory -data "$WDIR_HEX"
echo "  ✓ dossier des widgets : ${DOT/#$HOME/~}/ubersicht"

step "Réglages macOS"
"$DOT/macos.sh"

step "Services"
open -a "Übersicht" && echo "  ✓ Übersicht"

printf '\n\033[1;32m✓ Terminé.\033[0m Ouvre Ghostty, puis lance nvim une première fois (installation des plugins).\n'
