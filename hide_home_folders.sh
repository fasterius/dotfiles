#!/bin/bash

# Script that hides the default OS X home folders from Finder, but creates a
# new subdirectory with symbolic links to them for access when needed.

# Move to home directory
cd ~

# Create directory for symlinks
mkdir home

# Directories to hide
DIRS='Desktop'
DIRS=$DIRS' Documents'
DIRS=$DIRS' Downloads'
DIRS=$DIRS' Dropbox'
DIRS=$DIRS' Library'
DIRS=$DIRS' Movies'
DIRS=$DIRS' Music'
DIRS=$DIRS' Pictures'
DIRS=$DIRS' Public'

# Loop over directories
for DIR in $DIRS; do

    # Get lowercase directory name
    DIRNAME=$(echo $DIR | tr '[:upper:]' '[:lower:]')

    # Make symlink
    ln -s ~/$DIR home/$DIRNAME

    # Hide directory from Finder
    SetFile -a V $DIR
done
