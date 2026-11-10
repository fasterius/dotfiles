#!/usr/bin/env bash

# Script to run every install script in a OS-specific manner

source "$HOME/.dotfiles/scripts/dotfiles-host.sh"

# Run common scripts
echo ""
echo "--------------  Creating symlinks -------------- "
bash ~/.dotfiles/install/create-symlinks.sh

echo ""
echo "--------------  Installing fonts -------------- "
bash ~/.dotfiles/install/install-fonts.sh

echo ""
echo "--------------  Installing Pixi software -------------- "
bash ~/.dotfiles/install/install-with-pixi.sh

echo ""
echo "--------------  Installing Homebrew software --------------"
bash ~/.dotfiles/install/brew-install.sh

echo ""
echo "--------------  Installing Nextflow language server --------------"
bash ~/.dotfiles/install/install-nextflow-ls.sh

# MacOS-specific scripts
if [[ "$DOTFILES_OS" == "darwin" ]]; then
    echo ""
    echo "--------------  Hiding MacOS home directories --------------"
    bash ~/.dotfiles/install/macos-hide-directories.sh

    echo ""
    echo "--------------  Installing launchd services --------------"
    bash ~/.dotfiles/install/macos-launchd-services.sh
fi
