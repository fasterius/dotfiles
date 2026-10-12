#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository

# Get current OS
OS="$(uname)"

# Make sure a temporary directory for storing (Neo)vim's history/backups exists
mkdir -p $HOME/.tmp

# ------------------------------- XDG Configs ----------------------------------

# Make sure XDG config directory exists
mkdir -p $HOME/.config

# List config files to be symlinked into XDG-compliant directories
CONFIGS=(
    alacritty
    bat
    btop
    marksman
    nvim
    stylua
    vim
)

# Configs only linked when the software is installed
if command -v feh > /dev/null; then
    CONFIGS+=(feh)
fi
if command -v gnome-shell > /dev/null; then
    CONFIGS+=(gnome/run-or-raise)
fi

# Create symlinks in `$HOME/.config`
echo "Creating XDG-compliant symlinks ..."
for CONFIG in ${CONFIGS[@]}; do
    ln -sfn $HOME/.dotfiles/$CONFIG $HOME/.config
done

# ------------------------------ Home configs ----------------------------------

# List config files to be symlinked into $HOME
CONFIGS_HOME=(
    bash/bashrc
    bash/bash_profile
    bash/inputrc
    conda/condarc
    git/gitconfig
    git/gitignore_global
    lintr/lintr
    tmux/tmux.conf
)

# MacOS-only software
if [[ "$OS" == "Darwin" ]]; then
    CONFIGS_HOME+=(scripts/docker-X11-interactive/xinitrc.d)
fi

# Create symlinks in home directory
echo "Creating home directory symlinks ..."
for CONFIG in ${CONFIGS_HOME[@]}; do
    ln -sfn $HOME/.dotfiles/$CONFIG $HOME/.$(basename $CONFIG)
done

# ----------------------------- Custom configs --------------------------------

echo "Creating custom symlinks ..."

# Pixi can only use XDG-compliant directories for both the config and the global
# manifest on Linux, while using $HOME/.pixi works on both systems, so a
# specific setup is used here.

mkdir -p $HOME/.pixi/manifests
ln -sfn $HOME/.dotfiles/pixi/config.toml $HOME/.pixi
ln -sfn $HOME/.dotfiles/pixi/manifests/pixi-global.toml $HOME/.pixi/manifests

# The SSH config should be tracked by dotfiles, but not the `$HOME/.ssh` directory
# itself, as that is written to by the system.

mkdir -p $HOME/.ssh/sockets
ln -sfn $HOME/.dotfiles/ssh/config $HOME/.ssh


# ----------------------- Colour scheme-specific configs -----------------------

# Some configs can't select their colour scheme at runtime, so the file for the
# current host's colour scheme (`<name>-<colourscheme>.<ext>`) is symlinked to
# `<name>.<ext>`.

COLOURSCHEME="$($HOME/.dotfiles/scripts/dotfiles-colourscheme.sh)"
COLOURSCHEME_CONFIGS=(
    alacritty/alacritty.toml
    bash/inputrc-colours
    btop/btop.conf
)

echo "Creating symlinks for the \"$COLOURSCHEME\" colour scheme ..."
for CONFIG in ${COLOURSCHEME_CONFIGS[@]}; do
    if [[ "$CONFIG" == *.* ]]; then
        SOURCE="${CONFIG%.*}-$COLOURSCHEME.${CONFIG##*.}"
    else
        SOURCE="$CONFIG-$COLOURSCHEME"
    fi
    ln -sfn $HOME/.dotfiles/$SOURCE $HOME/.dotfiles/$CONFIG
done

# --------------------------------- Scripts -----------------------------------

# List scripts to be symlinked
SCRIPTS=(
    apptainer-in-docker.sh
    conda-intel-env/conda-intel-env.sh
    docker-X11-interactive/docker-X11-interactive.sh
    tmux-new.sh
)

# Linux-only scripts
if [[ "$OS" == "Linux" ]]; then
    SCRIPTS+=(proton-ge-update.sh)
fi

mkdir -p $HOME/.local/bin

# Symlink all scripts into `$HOME/.local/bin`
echo "Creating script symlinks ..."
for SCRIPT in ${SCRIPTS[@]}; do
    ln -sfn "$HOME/.dotfiles/scripts/$SCRIPT" $HOME/.local/bin
done

# ------------------------------- GNOME settings -------------------------------

# Load GNOME settings with `dconf`; uses an `@HOME@` placeholder for the home
# directory, as dconf can't expand variables.

if command -v gnome-shell > /dev/null && command -v dconf > /dev/null; then
    echo "Loading GNOME settings ..."
    sed "s|@HOME@|$HOME|g" $HOME/.dotfiles/gnome/settings.dconf \
        | dconf load /
fi
