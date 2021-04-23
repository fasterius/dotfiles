#!/bin/bash

# Create a symbolic link for the vimrc file
ln -s ~/.vim/vimrc ~/.vimrc

# Install vim plugins using VimPlug
vim +PlugInstall +qall
