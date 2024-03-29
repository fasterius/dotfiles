#!/bin/bash

# Install Homebrew non-interactively
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install formulae
brew install \
    bash \
    bash-completion \
    bat \
    black \
    coreutils \
    docker-completion \
    fd \
    gawk \
    gcc \
    git \
    gh \
    gnu-sed \
    gnu-tar \
    graphviz \
    gzip \
    imagemagick \
    lua-language-server \
    marksman \
    neovim \
    openjdk@17 \
    pandoc \
    prettier \
    pyright \
    r@4.3 \
    readline \
    ripgrep \
    tmux \
    tree \
    tree-sitter \
    vim \
    wget

# Install casks
brew install --cask \
    font-meslo-lg-nerd-font

# Install R language server non-interactively
R -e 'install.packages("languageserver", repos="http://lib.stat.cmu.edu/R/CRAN")'
