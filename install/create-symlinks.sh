#!/bin/bash

# Script that creates symbolic links for all relevant files in the repository

# Get current OS
OS="$(uname)"

# ------------------------------- XDG Configs ----------------------------------

# Make sure `~/.config` exists
mkdir -p ~/.config

# Make sure a temporary directory for storing (Neo)vim's history/backups exists
mkdir -p ~/.tmp

# List config files to be symlinked into XDG-compliant directories
CONFIGS=(
    alacritty
    btop
    jj
    marksman
    stylua
    nvim
    pixi
    vim
)

# Linux-only software
if [[ "$OS" == "Linux" ]]; then
    CONFIGS+=(
        feh
        gnome/run-or-raise
        mako
        niri
        waybar
    )
fi

# Create symlinks in `$HOME/.config`
for CONFIG in ${CONFIGS[@]}; do
    ln -sfn $HOME/.dotfiles/$CONFIG $HOME/.config
done

# -------------------------------- Alacritty -----------------------------------

# Different font sizes are required for different OSs for Alacritty, which is
# managed by symlinking the specific OS's config file to `alacritty.toml`
if [[ "$OS" == "Linux" ]]; then
    ln -sfn \
        ~/.dotfiles/alacritty/alacritty-linux.toml \
        ~/.dotfiles/alacritty/alacritty.toml
else
    ln -sfn \
        ~/.dotfiles/alacritty/alacritty-darwin.toml \
        ~/.dotfiles/alacritty/alacritty.toml
fi

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
for CONFIG in ${CONFIGS_HOME[@]}; do
    ln -sfn $HOME/.dotfiles/$CONFIG $HOME/.$(basename $CONFIG)
done

# ---------------------------------- Scripts ----------------------------------

# Make sure that `~/.local/bin` exists
mkdir -p ~/.local/bin

# List scripts to be symlinked
SCRIPTS=(
    apptainer-in-docker.sh
    conda-intel-env/conda-intel-env.sh
    docker-X11-interactive/docker-X11-interactive.sh
    tmux-new.sh
)

# Symlink all scripts into `~/.local/bin`
for SCRIPT in ${SCRIPTS[@]}; do
    ln -sfn "$HOME/.dotfiles/scripts/$SCRIPT" ~/.local/bin
done
