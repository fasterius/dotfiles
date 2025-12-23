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

# Install formulae
echo "Installing brew formulae ..."
brew install \
    act \
    bash \
    bash-completion \
    bat \
    btop \
    coreutils \
    cmake \
    docker-completion \
    fd \
    ffmpeg \
    gawk \
    gcc \
    gh \
    git \
    gnu-sed \
    gnu-tar \
    graphviz \
    gzip \
    imagemagick \
    jj \
    lua \
    lua-language-server \
    marksman \
    neovim \
    openjdk@17 \
    pandoc \
    prettier \
    readline \
    ripgrep \
    ruff \
    sox \
    tmux \
    tree \
    tree-sitter \
    vim \
    wget

# Install casks
echo "Installing brew casks ..."
brew install --cask \
    keycastr
