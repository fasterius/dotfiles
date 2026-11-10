#!/usr/bin/env bash

# Script that lists missing software that the dotfiles rely on, and prints the
# versions of software with a minimum version requirement

# Commands used by the configs (see `nvim/lsp/` and `nvim/plugin/conform.lua`)
COMMANDS=(
    nvim tree-sitter fzf tmux rg fd git cc
    bash-language-server lua-language-server markdown-oxide marksman
    pyright-langserver typescript-language-server vim-language-server R
    nextflow-lsp
    prettier ruff stylua
    pixi nextflow nf-test
)

echo "Missing:"
for COMMAND in "${COMMANDS[@]}"; do
    if ! command -v "$COMMAND" > /dev/null; then
        echo "  $COMMAND"
    fi
done
if ! Rscript -e "library(languageserver)" > /dev/null 2>&1; then
    echo "  R languageserver"
fi

echo ""
echo "Versions (minimum in brackets):"
echo "  nvim (0.12):          $(nvim --version 2>/dev/null | head -n 1)"
echo "  tree-sitter (0.26.1): $(tree-sitter --version 2>/dev/null)"
echo "  fzf (0.48):           $(fzf --version 2>/dev/null)"
echo "  tmux (3.2):           $(tmux -V 2>/dev/null)"
