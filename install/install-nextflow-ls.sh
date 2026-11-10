#!/usr/bin/env bash

# Script for installing the latest release of the Nextflow language server into
# `~/.local/share/nextflow-language-server`, with its launcher linked as
# `~/.local/bin/nextflow-lsp`. Remove the bundle and re-run the script to update
# it.

source "$HOME/.dotfiles/scripts/dotfiles-host.sh"

DIR="$HOME/.local/share/nextflow-language-server"
BIN="$HOME/.local/bin"
REPO="https://github.com/nextflow-io/language-server"
API="https://api.github.com/repos/nextflow-io/language-server"

if [[ -x "$DIR/bin/nextflow-lsp" ]]; then
    echo "The Nextflow language server is already installed"
    ln -sfn "$DIR/bin/nextflow-lsp" "$BIN/nextflow-lsp"
    exit 0
fi

# Bundle for the current OS and architecture
case "$DOTFILES_OS-$(uname -m)" in
    darwin-arm64)  PLATFORM="macos-arm64" ;;
    linux-x86_64)  PLATFORM="linux-x64" ;;
    linux-aarch64) PLATFORM="linux-arm64" ;;
    *)
        echo "No Nextflow language server bundle for this platform" >&2
        exit 1
        ;;
esac

# Version of the latest release, without the leading `v`
VERSION="$(curl -fsSL "$API/releases/latest" \
    | grep -o '"tag_name": *"v[^"]*"' \
    | grep -o '[0-9][^"]*')"
if [[ -z "$VERSION" ]]; then
    echo "Could not find the latest Nextflow language server release" >&2
    exit 1
fi

# Download and unpack the bundle in a temporary directory
echo "Installing the Nextflow language server $VERSION ..."
BUNDLE="nextflow-language-server-$VERSION-$PLATFORM"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cd "$TMP" || exit 1
curl -fsSLO "$REPO/releases/download/v$VERSION/$BUNDLE.tar.gz" || exit 1
tar -xzf "$BUNDLE.tar.gz" || exit 1

# Move the bundle into place and link its launcher
mkdir -p "$(dirname "$DIR")" "$BIN"
mv "$BUNDLE" "$DIR"
ln -sfn "$DIR/bin/nextflow-lsp" "$BIN/nextflow-lsp"
