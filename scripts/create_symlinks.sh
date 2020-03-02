#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository

# Bash
ln -s ~/.bash/profiles/bashrc ~/.bashrc
ln -s ~/.bash/profiles/bash_profile ~/.bash_profile

# Conda
ln -s ~/.bash/profiles/condarc ~/.condarc

# Git
ln -s ~/.bash/git/gitconfig ~/.gitconfig
ln -s ~/.bash/git/gitignore_global ~/.gitignore_global
