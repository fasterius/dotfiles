#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository
# and installs all Vim plugins

# Bash
ln -sfn ~/.dotfiles/profiles/bashrc ~/.bashrc
ln -sfn ~/.dotfiles/profiles/bash_profile ~/.bash_profile

# Conda
ln -sfn ~/.dotfiles/profiles/condarc ~/.condarc

# Git
ln -sfn ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sfn ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# Tmux
ln -sfn ~/.dotfiles/profiles/tmux.conf ~/.tmux.conf

# Terminfo
cp -r ~/.dotfiles/profiles/terminfo ~/.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux-256color.terminfo
tic -o ~/.terminfo ~/.terminfo/xterm-256color.terminfo

# Vim
ln -sfn ~/.dotfiles/vim/vimrc ~/.vimrc

# Install Vim plugins using VimPlug
vim +PlugInstall +qall
