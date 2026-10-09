#!/usr/bin/bash

# Script to install Meslo LGS Nerd Font Mono

OS="$(uname)"
if [[ "$OS" == "Linux" ]]; then
    FONT_PATH="$HOME/.local/share/fonts/"
elif [[ "$OS" == "Darwin" ]]; then
    FONT_PATH="$HOME/Library/Fonts/"
fi

# Check if font is already installed
FONT_NAME="MesloLGSNerdFontMono"
INSTALLED=true
for STYLE in Regular Bold BoldItalic Italic; do
    if [[ ! -f "$FONT_PATH/$FONT_NAME-$STYLE.ttf" ]]; then
        INSTALLED=false
    fi
done
if [[ "$INSTALLED" == true ]]; then
    echo "$FONT_NAME already installed"
    exit 0
fi

# Download and install font
echo "Installing $FONT_NAME ..."
mkdir -p "$FONT_PATH"
mkdir meslo
curl -o meslo.tar.xz \
    -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.tar.xz
tar -xf meslo.tar.xz -C meslo
mv meslo/MesloLGSNerdFontMono*.ttf "$FONT_PATH"
rm -r meslo/ meslo.tar.xz
