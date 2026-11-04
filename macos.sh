#!/usr/bin/env bash
# Réglages macOS · relançable sans risque
set -euo pipefail
DOT="$(cd "$(dirname "$0")" && pwd)"

# Bureau : aucune icône (les dossiers restent dans le Finder, ~/Desktop)
defaults write com.apple.finder CreateDesktop -bool false

# Captures d'écran rangées dans Images/Screenshots
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture show-thumbnail -bool true

# Dock : masqué automatiquement, apparition rapide, pas d'apps récentes
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.35
defaults write com.apple.dock show-recents -bool false

# Ne pas masquer les fenêtres quand on clique sur le fond d'écran (gênant avec les widgets)
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Fond d'écran Catppuccin
if [[ -f $DOT/wallpaper/catppuccin-mocha.png ]]; then
  osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$DOT/wallpaper/catppuccin-mocha.png\"" || true
fi

killall Finder Dock SystemUIServer 2>/dev/null || true
echo "✓ Réglages macOS appliqués"
