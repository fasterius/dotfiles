#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository
# and installs all Vim plugins

# Bash
ln -sfn ~/.bash/profiles/bashrc ~/.bashrc
ln -sfn ~/.bash/profiles/bash_profile ~/.bash_profile

# Conda
ln -sfn ~/.bash/profiles/condarc ~/.condarc

# Git
ln -sfn ~/.bash/git/gitconfig ~/.gitconfig
ln -sfn ~/.bash/git/gitignore_global ~/.gitignore_global

# Tmux
ln -sfn ~/.bash/profiles/tmux.conf ~/.tmux.conf

# Terminfo
cp -r ~/.bash/terminfo ~/.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux-256color.terminfo
tic -o ~/.terminfo ~/.terminfo/xterm-256color.terminfo

# Vim
ln -sfn ~/.vim/vimrc ~/.vimrc

# Install Vim plugins using VimPlug
vim +PlugInstall +qall
