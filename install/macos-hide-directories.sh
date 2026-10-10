#!/bin/bash

# Script that hides the default MacOS home folders from Finder, but creates a
# new subdirectory with symbolic links to them for access when needed. Safe to
# run multiple times.

# Create directory for symlinks
mkdir -p "$HOME/home"

# Directories to hide
DIRS=(
    Desktop
    Documents
    Downloads
    Library
    Movies
    Music
    Pictures
    Public
)

# Loop over directories
for DIR in "${DIRS[@]}"; do

    # Get lowercase directory name
    DIRNAME=$(echo "$DIR" | tr '[:upper:]' '[:lower:]')

    # Make symlink, replacing any existing one
    ln -sfn "$HOME/$DIR" "$HOME/home/$DIRNAME"

    # Hide directory from Finder
    SetFile -a V "$HOME/$DIR"
done
