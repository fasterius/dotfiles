#!/usr/bin/env bash

# Script for installing Pixi and the environments in its global manifest

LOCAL="$HOME/.local"
BIN="$HOME/.local/bin"
mkdir -p "$BIN"

# Pixi (the binary in `~/.local/bin`, not in the global environments' directory)
if [[ ! -x "$BIN/pixi" ]]; then
    echo "Installing Pixi ..."
    curl -fsSL https://pixi.sh/install.sh \
        | PIXI_HOME="$LOCAL" PIXI_NO_PATH_UPDATE=1 bash
else
    echo "Pixi is already installed"
fi

# Pixi global environments, from the manifest linked by `create-symlinks.sh`
echo "Installing Pixi global environments ..."
PIXI="$(command -v pixi || echo "$BIN/pixi")"
"$PIXI" global sync
