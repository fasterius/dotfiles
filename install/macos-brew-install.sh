#!/bin/bash

# Script for installing Homebrew itself as well as software installed by it on
# MacOS systems. Does not install anything on non-Darwin systems.

# Check for MacOS
if [[ ! "$(uname)" == "Darwin" ]]; then
    echo "Not on MacOS; not installing Homebrew"
    exit 0
fi

# Install Homebrew non-interactively
if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew ..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install everything listed in the Brewfile
echo "Installing Homebrew packages ..."
BREW="$(command -v brew || echo /opt/homebrew/bin/brew)"
"$BREW" bundle --file="$HOME/.dotfiles/brew/Brewfile"
