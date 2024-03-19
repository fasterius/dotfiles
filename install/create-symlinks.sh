#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository

# Alacritty
ln -sfn ~/.dotfiles/alacritty/alacritty.yml ~/.alacritty.yml

# Bash
ln -sfn ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/bash_profile ~/.bash_profile

# Conda
ln -sfn ~/.dotfiles/conda/condarc ~/.condarc

# Git
ln -sfn ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sfn ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# Language servers
mkdir -p ~/.config/marksman
ln -sfn ~/.dotfiles/lsp/marksman/config.toml ~/.config/marksman/config.toml
ln -sfn ~/.dotfiles/lsp/lintr/lintr ~/.lintr

# Code formatting
ln -sfn ~/.dotfiles/stylua/stylua.toml ~/.stylua.toml

# NeoVim
mkdir -p ~/.config
ln -sfn ~/.dotfiles/nvim ~/.config/nvim

# Temporary directory for storing (Neo)vim's history and backups
mkdir -p ~/.tmp

# Tmux
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# Vim
ln -sfn ~/.dotfiles/vim ~/.vim
ln -sfn ~/.vim/vimrc ~/.vimrc
