#!/usr/bin/bash

# Script to install Meslo LGS Nerd Font Mono

echo "Installing Meslo LGS Nerd Font Mono ..."

OS="$(uname)"
if [[ "$OS" == "Linux" ]]; then
    FONT_PATH="~/.local/share/fonts/"
elif [[ "$OS" == "Darwin" ]]; then
    FONT_PATH="~/Library/Fonts/"
fi

mkdir -p "$FONT_PATH"
mkdir meslo
curl -o meslo.tar.xz \
    -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.tar.xz
tar -xf meslo.tar.xz -C meslo
mv meslo/MesloLGSNerdFontMono*.ttf "$FONT_PATH"
rm -r meslo/ meslo.tar.xz
echo "Done."
