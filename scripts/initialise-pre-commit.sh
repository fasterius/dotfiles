#!/bin/bash

# Script for initialising `pre-commit` in a repo from the `pre-commit` template,
# which uses conventional commits and conventional branches.

set -euo pipefail

TEMPLATE="$HOME/.dotfiles/pre-commit/pre-commit-config-template.yaml"
TARGET=".pre-commit-config.yaml"

# Check if this is in a Git repo
if [ ! -d ".git" ]; then
    echo "ERROR: Not at the root of Git repository"
    exit 1
fi

# Don't overwrite an existing config
if [ -f "$TARGET" ]; then
    echo "ERROR: $TARGET already exists"
    exit 1
fi

cp "$TEMPLATE" "$TARGET"

pre-commit install
pre-commit run --all-files || true

echo "Done! Pre-commit configured."
