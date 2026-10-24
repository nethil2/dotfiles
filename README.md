# nethil2 MacOS

Made with OmniWM, SketchyBar, Alfred and more

![Uploading CleanShot 2026-10-25 at 7.33.49 AM@2x.png…]()

![Uploading CleanShot 2026-10-25 at 7.34.11 AM@2x.png…]()


## Dependencies

You might need to run `brew update` and `brew upgrade` first.

```sh
xcode-select --install

# Homebrew taps
brew tap FelixKratz/formulae
brew tap albertlauncher/albert

# Core CLI tools
brew install coreutils fish python lua neovim macchina media-control jq \
  ripgrep fastfetch

# Window management / bar / borders
brew install koekeishiya/formulae/skhd \
  FelixKratz/formulae/borders \
  FelixKratz/formulae/sketchybar

# Monitors / extras
brew install btop cava yabai opencode

# Casks
brew install --cask alacritty omniwm \
  font-space-mono-nerd-font font-gabarito \
  font-jetbrains-mono-nerd-font font-sketchybar-app-font \
  microsoft-outlook zen vorssaint wispr-flow
```

### Apps not available via Homebrew (install manually)

- **Alfred 5** — https://www.alfredapp.com/
- **Alcove** — App Store
- **CleanShot X** — https://cleanshot.com/
- **Droppy** — App Store
- **Glance** — App Store
- **Seam** — App Store
- **Sound Show 2** — App Store
- **Alacritty** (if not via brew) — https://alacritty.org/

### Custom helper

SketchyBar's Wi-Fi item uses a small helper at `~/Applications/WifiSSIDHelper.app`. Build it from the Swift sources in `/tmp/WifiSSIDHelper.swift` (or skip the Wi-Fi item).

## Installation

```sh
# clone this repo
git clone --recurse-submodules https://github.com/pgkyg79f6w-blip/dotfiles
cd dotfiles

# copy config
mkdir -p ~/.config
cp -r .config/* ~/.config/

# build lua sketchybar
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
chmod +x ~/.config/borders/bordersrc ~/.config/sketchybar/sketchybarrc

# run services
open -a OmniWM
brew services start sketchybar
brew services start borders
skhd --start-service
```

- You'd need to grant permissions to OmniWM, SketchyBar, JankyBorders, skhd, and Alfred at **Settings > Privacy & Security > Accessibility**.
- You'd want to launch them on startup too: **Settings > General > Login Items & Extensions**.

## Notes

- Check [skhd config](./.config/skhd/skhdrc) for hotkeys.
- Check [fish config](./.config/fish/config.fish) for expected dirs in `$PATH` variables.
- OmniWM settings live in `~/.config/omniwm/settings.toml`.
- SketchyBar settings live in `~/.config/sketchybar/`.
