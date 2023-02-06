#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository

# Bash
ln -sfn ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/bash_profile ~/.bash_profile

# Conda
ln -sfn ~/.dotfiles/conda/condarc ~/.condarc

# Git
ln -sfn ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sfn ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# Tmux
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# Terminfo
cp -r ~/.dotfiles/terminfo ~/.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux-256color.terminfo
tic -o ~/.terminfo ~/.terminfo/xterm-256color.terminfo

# Vim
ln -sfn ~/.dotfiles/vim ~/.vim
ln -sfn ~/.vim/vimrc ~/.vimrc

# NeoVim
mkdir -p ~/.config
ln -sfn ~/.dotfiles/nvim ~/.config/nvim

# Directory for storing (Neo)vim's history and backups
mkdir -p ~/.tmp

# Alacritty
ln -sfn ~/.dotfiles/alacritty/alacritty.yml ~/.alacritty.yml
