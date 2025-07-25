#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository

# Alacritty
ln -sfn ~/.dotfiles/alacritty ~/.config

# Bash
ln -sfn ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/bash_profile ~/.bash_profile
ln -sfn ~/.dotfiles/bash/inputrc ~/.inputrc

# Btop
ln -sfn ~/.dotfiles/btop ~/.config

# Conda
ln -sfn ~/.dotfiles/conda/condarc ~/.condarc

# Git
ln -sfn ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sfn ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# Jujutstu
ln -sfn ~/.dotfiles/jj ~/.config

# Language servers
ln -sfn ~/.dotfiles/lsp/marksman ~/.config
ln -sfn ~/.dotfiles/lsp/lintr/lintr ~/.lintr

# Code formatting
ln -sfn ~/.dotfiles/stylua ~/.config

# NeoVim
ln -sfn ~/.dotfiles/nvim ~/.config

# Pixi
ln -sfn ~/.dotfiles/pixi ~/.config

# Temporary directory for storing (Neo)vim's history and backups
mkdir -p ~/.tmp

# Tmux
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# Vim
ln -sfn ~/.dotfiles/vim ~/.vim
ln -sfn ~/.vim/vimrc ~/.vimrc

# XQuartz (MacOS only)
if [[ "$(uname)" == "Darwin" ]]; then
	ln -sfn ~/.dotfiles/x11/xinitrc.d ~/.xinitrc.d
fi
