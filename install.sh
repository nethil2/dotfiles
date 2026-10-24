#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[*] Nethil2 MacOs installer"
echo "[*] Dotfiles dir: $DOTFILES_DIR"

# Install Homebrew if missing
if ! command -v brew >/dev/null 2>&1; then
  echo "[*] Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "[*] Homebrew found"
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Taps
brew tap FelixKratz/formulae 2>/dev/null || true

# Install formulae
echo "[*] Installing formulae..."
brew install coreutils fish python lua neovim ripgrep fastfetch \
  macchina btop cava jq \
  koekeishiya/formulae/skhd \
  FelixKratz/formulae/sketchybar \
  emacs opencode yabai \
  ca-certificates cask gettext gmp gnutls iniparser json-c \
  libidn2 libomp libtasn1 libunistring libuv lpeg luajit luv lz4 \
  media-control mpdecimal nettle oniguruma openssl@4 p11-kit \
  pcre2 portaudio readline removemacai sqlite tree-sitter unibilium utf8proc xz yyjson zstd

# Install casks
echo "[*] Installing casks..."
brew install --cask alacritty omniwm zen wispr-flow vorssaint \
  font-space-mono-nerd-font font-gabarito font-jetbrains-mono-nerd-font font-sketchybar-app-font \
  microsoft-outlook

# Link configs
echo "[*] Linking configs..."
"$DOTFILES_DIR/scripts/link.sh"

# Build SbarLua for SketchyBar
if [ ! -d /tmp/SbarLua ]; then
  echo "[*] Building SbarLua..."
  git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua
  (cd /tmp/SbarLua && make install)
  rm -rf /tmp/SbarLua
else
  (cd /tmp/SbarLua && make install) || true
  rm -rf /tmp/SbarLua
fi

# Permissions
chmod +x "$HOME/.config/sketchybar/sketchybarrc" "$HOME/.config/skhd"/*.sh 2>/dev/null || true

# Start services
echo "[*] Starting services..."
open -a OmniWM 2>/dev/null || true
brew services start sketchybar 2>/dev/null || true
skhd --start-service 2>/dev/null || true

echo "[+] Installation complete!"
echo "[i] Grant Accessibility permissions to OmniWM, SketchyBar, skhd, Alfred, CleanShot X in System Settings > Privacy & Security > Accessibility"
echo "[i] Add them to Login Items & Extensions if desired"
