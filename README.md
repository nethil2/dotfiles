
# nethil2 MacOS

Made with OmniWM, SketchyBar, JankyBorders, and more...

## Dependencies

You might need to run `brew update` and `brew upgrade` first.

```sh
xcode-select --install
brew tap FelixKratz/formulae
brew tap albertlauncher/albert

brew install coreutils fish python lua neovim macchina media-control jq \
  koekeishiya/formulae/skhd \
  FelixKratz/formulae/borders \
  FelixKratz/formulae/sketchybar
brew install --cask alacritty omniwm albert \
  font-space-mono-nerd-font font-gabarito
```

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

- You'd need to grant permissions to OmniWM, SketchyBar, JankyBorders, skhd, and Albert at **Settings > Privacy & Security > Accessibility**.
- You'd want to launch them on startup too: **Settings > General > Login Items & Extensions**.

## Notes

- Check [skhd config](./.config/skhd/skhdrc) for hotkeys.
- Check [fish config](./.config/fish/config.fish) for expected dirs in `$PATH` variables.

