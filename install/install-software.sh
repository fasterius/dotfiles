#!/usr/bin/bash

LOCAL="$HOME/.local"
BIN="$HOME/.local/bin"

# Pixi
if [[ ! -x "$BIN/pixi" ]]; then
    echo "Installing Pixi ..."
    export PIXI_HOME=$LOCAL
    export PIXI_NO_PATH_UPDATE=1
    curl -fsSL https://pixi.sh/install.sh | bash
else
    echo "Pixi is already installed"
fi

# Nextflow
if [[ ! -x "$BIN/nextflow" ]]; then
    echo "Installing Nextflow ..."
    curl -s https://get.nextflow.io | bash
    mv nextflow $BIN
else
    echo "Nextflow is already installed"
fi
