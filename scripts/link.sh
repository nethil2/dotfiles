#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "[*] Dotfiles: $DOTFILES_DIR"

mkdir -p "$HOME/.config" "$HOME/Library/Preferences" "$HOME/Library/Application Support" "$HOME/Applications"

link_dir() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  ln -s "$src" "$dst"
  echo "  ln -s $src -> $dst"
}

link_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  rm -f "$dst"
  ln -s "$src" "$dst"
  echo "  ln -s $src -> $dst"
}

# .config
[ -d "$DOTFILES_DIR/dotfiles/alacritty" ] && link_dir "$DOTFILES_DIR/dotfiles/alacritty" "$HOME/.config/alacritty"
[ -d "$DOTFILES_DIR/dotfiles/btop" ] && link_dir "$DOTFILES_DIR/dotfiles/btop" "$HOME/.config/btop"
[ -d "$DOTFILES_DIR/dotfiles/cava" ] && link_dir "$DOTFILES_DIR/dotfiles/cava" "$HOME/.config/cava"
[ -d "$DOTFILES_DIR/dotfiles/fish" ] && link_dir "$DOTFILES_DIR/dotfiles/fish" "$HOME/.config/fish"
[ -d "$DOTFILES_DIR/dotfiles/karabiner" ] && link_dir "$DOTFILES_DIR/dotfiles/karabiner" "$HOME/.config/karabiner"
[ -d "$DOTFILES_DIR/dotfiles/macchina" ] && link_dir "$DOTFILES_DIR/dotfiles/macchina" "$HOME/.config/macchina"
[ -d "$DOTFILES_DIR/dotfiles/omniwm" ] && link_dir "$DOTFILES_DIR/dotfiles/omniwm" "$HOME/.config/omniwm"
[ -d "$DOTFILES_DIR/dotfiles/opencode" ] && link_dir "$DOTFILES_DIR/dotfiles/opencode" "$HOME/.config/opencode"
[ -d "$DOTFILES_DIR/dotfiles/sketchybar" ] && link_dir "$DOTFILES_DIR/dotfiles/sketchybar" "$HOME/.config/sketchybar"
[ -d "$DOTFILES_DIR/dotfiles/skhd" ] && link_dir "$DOTFILES_DIR/dotfiles/skhd" "$HOME/.config/skhd"
[ -d "$DOTFILES_DIR/dotfiles/yabai" ] && link_dir "$DOTFILES_DIR/dotfiles/yabai" "$HOME/.config/yabai"

# Alfred prefs
[ -f "$DOTFILES_DIR/dotfiles/alfred/com.runningwithcrayons.Alfred.plist" ] && link_file "$DOTFILES_DIR/dotfiles/alfred/com.runningwithcrayons.Alfred.plist" "$HOME/Library/Preferences/com.runningwithcrayons.Alfred.plist"
[ -f "$DOTFILES_DIR/dotfiles/alfred/com.runningwithcrayons.Alfred-Preferences.plist" ] && link_file "$DOTFILES_DIR/dotfiles/alfred/com.runningwithcrayons.Alfred-Preferences.plist" "$HOME/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist"
[ -d "$DOTFILES_DIR/dotfiles/alfred" ] && link_dir "$DOTFILES_DIR/dotfiles/alfred" "$HOME/Library/Application Support/Alfred"

# CleanShot
[ -d "$DOTFILES_DIR/dotfiles/cleanshot" ] && link_dir "$DOTFILES_DIR/dotfiles/cleanshot" "$HOME/Library/Application Support/CleanShot"

# OmniWM app support
[ -d "$DOTFILES_DIR/dotfiles/omniwm-app" ] && link_dir "$DOTFILES_DIR/dotfiles/omniwm-app" "$HOME/Library/Application Support/com.barut.OmniWM"

# Wispr Flow
[ -d "$DOTFILES_DIR/dotfiles/wispr-flow" ] && link_dir "$DOTFILES_DIR/dotfiles/wispr-flow" "$HOME/Library/Application Support/Wispr Flow"

echo "[+] Done. Configs are now symlinked to repo."
