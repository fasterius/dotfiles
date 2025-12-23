#!/usr/bin/bash

# Script to install Meslo LGS Nerd Font Mono

echo "Installing Meslo LGS Nerd Font Mono ..."

OS="$(uname)"
if [[ "$OS" == "Linux" ]]; then
    FONT_PATH="~/.local/share/fonts/"
elif [[ "$OS" == "Darwin" ]]; then
    FONT_PATH="~/Library/Fonts/"
fi

# Check if font is already installed
FONT_NAME="MesloLGSNerdFontMono"
FONT_FILES=("$FONT_PATH"/$FONT_NAME-{Regular,Bold,BoldItalic,Italic}.ttf)
if (( ${#FONT_FILES[@]} == 4 )); then
    echo "Font already installed"
    exit 0
fi

# Download and install font
mkdir -p "$FONT_PATH"
mkdir meslo
curl -o meslo.tar.xz \
    -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.tar.xz
tar -xf meslo.tar.xz -C meslo
mv meslo/MesloLGSNerdFontMono*.ttf "$FONT_PATH"
rm -r meslo/ meslo.tar.xz
