# Nethil2 MacOs

This repo is a complete snapshot of my macOS setup so I can recreate it on a new MacBook.

## 1) Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

For Apple Silicon, make sure Homebrew is in your PATH (add to your shell profile if needed):

```sh
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## 2) Install all packages (formulae + casks)

```sh
# Taps
brew tap FelixKratz/formulae

# Formulae
brew install coreutils fish python lua neovim ripgrep fastfetch \
  macchina btop cava jq \
  koekeishiya/formulae/skhd \
  FelixKratz/formulae/sketchybar \
  emacs opencode yabai \
  ca-certificates cask gettext gmp gnutls iniparser json-c \
  libidn2 libomp libtasn1 libunistring libuv lpeg luajit luv lz4 \
  media-control mpdecimal nettle oniguruma openssl@4 p11-kit \
  pcre2 portaudio readline removemacai sqlite tree-sitter unibilium utf8proc xz yyjson zstd

# Casks
brew install --cask alacritty omniwm zen wispr-flow vorssaint \
  font-space-mono-nerd-font font-gabarito font-jetbrains-mono-nerd-font font-sketchybar-app-font \
  microsoft-outlook
```

### Manual apps (not always in Homebrew)

- Alfred 5 — https://www.alfredapp.com/
- CleanShot X — https://cleanshot.com/
- RemoveMacAI — already included via formulae `removemacai` if available

## 3) Clone this repo

```sh
git clone --recurse-submodules https://github.com/pgkyg79f6w-blip/dotfiles
cd dotfiles
```

## 4) Copy all configs

```sh
# Link/copy dotfiles to ~/.config
mkdir -p ~/.config ~/.local/share ~/.local/bin
cp -r dotfiles/alacritty/* ~/.config/alacritty/ 2>/dev/null || mkdir -p ~/.config/alacritty && cp -r dotfiles/alacritty/* ~/.config/alacritty/
cp -r dotfiles/btop/* ~/.config/btop/
cp -r dotfiles/cava/* ~/.config/cava/
mkdir -p ~/.config/fish
cp dotfiles/fish/config.fish ~/.config/fish/ 2>/dev/null
cp -r dotfiles/fish/* ~/.config/fish/ 2>/dev/null
mkdir -p ~/.config/karabiner
cp dotfiles/karabiner/karabiner.json ~/.config/karabiner/
mkdir -p ~/.config/macchina
cp -r dotfiles/macchina/* ~/.config/macchina/
mkdir -p ~/.config/omniwm
cp -r dotfiles/omniwm/* ~/.config/omniwm/
mkdir -p ~/.config/opencode
cp -r dotfiles/opencode/* ~/.config/opencode/
mkdir -p ~/.config/sketchybar
cp -r dotfiles/sketchybar/* ~/.config/sketchybar/
mkdir -p ~/.config/skhd
cp -r dotfiles/skhd/* ~/.config/skhd/
mkdir -p ~/.config/yabai
cp -r dotfiles/yabai/* ~/.config/yabai/
```

## 5) Restore app preferences

```sh
# Alfred
mkdir -p ~/Library/Application\ Support/Alfred ~/Library/Preferences
cp dotfiles/alfred/com.runningwithcrayons.Alfred*.plist ~/Library/Preferences/ 2>/dev/null
cp -r dotfiles/alfred/* ~/Library/Application\ Support/Alfred/ 2>/dev/null

# CleanShot X
mkdir -p ~/Library/Application\ Support/CleanShot
cp -r dotfiles/cleanshot/* ~/Library/Application\ Support/CleanShot/ 2>/dev/null

# OmniWM app support (if present)
mkdir -p ~/Library/Application\ Support/com.barut.OmniWM
cp -r dotfiles/omniwm-app/* ~/Library/Application\ Support/com.barut.OmniWM/ 2>/dev/null

# Wispr Flow
mkdir -p ~/Library/Application\ Support/Wispr\ Flow
cp -r dotfiles/wispr-flow/* ~/Library/Application\ Support/Wispr\ Flow/ 2>/dev/null
```

## 6) Build deps & start services

```sh
# SbarLua for SketchyBar
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)

# Make scripts executable
chmod +x ~/.config/sketchybar/sketchybarrc ~/.config/skhd/*.sh 2>/dev/null

# Start services
open -a OmniWM
brew services start sketchybar
skhd --start-service
```

## 7) Permissions

Grant **Accessibility** access to: OmniWM, SketchyBar, skhd, Alfred, CleanShot X in  
**System Settings > Privacy & Security > Accessibility**.

Also add them to **Login Items & Extensions** if you want them on startup.
