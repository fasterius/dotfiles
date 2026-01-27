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
    bat
    btop
    jj
    marksman
    stylua
    nvim
    vim
)

# Home PC-only software
if [[ "$HOST" == "sajberspace" ]]; then
    CONFIGS+=(
        eww
        feh
        fuzzel
        gnome/run-or-raise
        mako
        niri
        quickshell
        waybar
    )
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

# ---------------------------------- Pixi -------------------------------------

# Pixi can only use XDG-compliant directories for both the config and the global
# manifest on Linux, while using $HOME/.pixi works on both systems, so a
# specific setup is used here.

echo "Creating Pixi symlinks ..."
mkdir -p $HOME/.pixi/manifests
ln -sfn $HOME/.dotfiles/pixi/config.toml $HOME/.pixi
ln -sfn $HOME/.dotfiles/pixi/manifests/pixi-global.toml $HOME/.pixi/manifests

# --------------------------- OS-specific configs -----------------------------

# Some configs requires symlinking different files depending on the current
# hostname, usually because of the desired colour scheme or font size.

HOST_CONFIGS=(
    alacritty.toml
    btop.conf
)

echo "Creating other symlinks ..."
for HOST_CONFIG in ${HOST_CONFIGS[@]}; do
    APP="${HOST_CONFIG/.*/}"
    EXT="${HOST_CONFIG/*./}"
    if [[ "$HOST" == "sajberspace" ]]; then
        ln -sfn \
            ~/.dotfiles/${APP}/${APP}-everforest.${EXT} \
            ~/.dotfiles/${APP}/${APP}.${EXT}
    else
        ln -sfn \
            ~/.dotfiles/${APP}/${APP}-solarized.${EXT} \
            ~/.dotfiles/${APP}/${APP}.${EXT}
    fi
done

# --------------------------------- Scripts -----------------------------------

# Make sure that `~/.local/bin` exists
mkdir -p ~/.local/bin

# List scripts to be symlinked
SCRIPTS=(
    apptainer-in-docker.sh
    conda-intel-env/conda-intel-env.sh
    docker-X11-interactive/docker-X11-interactive.sh
    tmux-find-sessions/tmux-find-sessions.sh
    tmux-new.sh
)

# Symlink all scripts into `~/.local/bin`
echo "Creating script symlinks ..."
for SCRIPT in ${SCRIPTS[@]}; do
    ln -sfn "$HOME/.dotfiles/scripts/$SCRIPT" ~/.local/bin
done
