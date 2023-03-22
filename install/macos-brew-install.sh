#!/bin/bash

# Install Homebrew non-interactively
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install formulae
brew install \
    bash \
    bat \
    black \
    coreutils \
    gawk \
    gcc \
    git \
    gnu-sed \
    graphviz \
    gzip \
    imagemagick \
    neovim \
    openjdk@17 \
    pandoc \
    readline \
    ripgrep \
    tmux \
    tree-sitter \
    vim \
    wget

# Install casks
brew install --cask \
    font-meslo-lg-nerd-font
