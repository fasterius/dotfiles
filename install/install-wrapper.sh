#!/usr/bin/env bash

# Script to run every install script in a OS-specific manner

# Run common scripts
echo ""
echo "--------------  Creating symlinks -------------- "
bash ~/.dotfiles/install/create-symlinks.sh

echo ""
echo "--------------  Installing fonts -------------- "
bash ~/.dotfiles/install/install-fonts.sh

echo ""
echo "--------------  Installing software -------------- "
bash ~/.dotfiles/install/install-software.sh

# MacOS-specific scripts
if [[ "$(uname)" == "Darwin" ]]; then
    echo ""
    echo "--------------  Hiding MacOS home directories --------------"
    bash ~/.dotfiles/isntall/macos-hide-directories.sh

    echo ""
    echo "--------------  Installing Homebrew software --------------"
    bash ~/.dotfiles/isntall/macos-brew-install.sh
fi
