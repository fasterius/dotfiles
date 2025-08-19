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

# MacOS-only software
if [[ "$(uname)" == "Darwin" ]]; then

    # XQuartz
	ln -sfn ~/.dotfiles/scripts/xinitrc.d ~/.xinitrc.d

fi

# Linux-only software
if [[ "$(uname)" == "Linux" ]]; then

    # Feh
    ln -sfn ~/.dotfiles/feh ~/.config

    # GNOME Run-or-raise extension
    ln -sfn ~/.dotfiles/run-or-raise ~/.config

    # Mako
    ln -sfn ~/.dotfiles/mako ~/.config

    # Niri
    ln -sfn ~/.dotfiles/niri ~/.config

    # Waybar
    ln -sfn ~/.dotfiles/waybar ~/.config

fi
