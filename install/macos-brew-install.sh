#!/bin/bash

# Install Homebrew non-interactively
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install formulae
brew install \
    act \
    bash \
    bash-completion \
    bat \
    black \
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
    pyright \
    python@3.12 \
    r@4.3 \
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
brew install --cask \
    font-meslo-lg-nerd-font \
    keycastr

# Install R language server non-interactively
R -e 'install.packages("languageserver", repos="http://lib.stat.cmu.edu/R/CRAN")'
