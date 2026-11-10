#!/bin/bash

# Script for installing the software in `brew/Brewfile` with Homebrew. On MacOS,
# Homebrew itself is installed if it's missing; on Linux, it's only used if it
# has already been installed.

source "$HOME/.dotfiles/scripts/dotfiles-host.sh"

# Find Homebrew path
BREW="$(command -v brew)"
for PREFIX in /opt/homebrew /home/linuxbrew/.linuxbrew; do
    if [[ -z "$BREW" && -x "$PREFIX/bin/brew" ]]; then
        BREW="$PREFIX/bin/brew"
    fi
done

# Check Homebrew installation
if [[ -z "$BREW" ]]; then
    if [[ "$DOTFILES_OS" != "darwin" ]]; then
        echo "Homebrew is not installed; not installing Homebrew packages"
        exit 0
    fi

    # Install Homebrew non-interactively on MacOS
    echo "Installing Homebrew ..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    BREW=/opt/homebrew/bin/brew
fi

# Install everything listed in the Brewfile
echo "Installing Homebrew packages ..."
"$BREW" bundle --file="$HOME/.dotfiles/brew/Brewfile"
