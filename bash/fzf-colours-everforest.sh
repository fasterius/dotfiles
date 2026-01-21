#!/usr/bin/env bash

# Solarized light colours for fzf
FZF_COLOURS="hl:#83c092"                   # Highlight: blue
FZF_COLOURS="$FZF_COLOURS,fg:#d3c6aa"      # Foreground: light grey
FZF_COLOURS="$FZF_COLOURS,bg:#272e33"      # Foreground: white
FZF_COLOURS="$FZF_COLOURS,hl+:#83c092"     # Selected highlight: cyan
FZF_COLOURS="$FZF_COLOURS,fg+:#d3c6aa"     # Selected foreground: grey
FZF_COLOURS="$FZF_COLOURS,bg+:#475258"     # Selected background: dark white
FZF_COLOURS="$FZF_COLOURS,prompt:#83c092"  # Prompt: blue
FZF_COLOURS="$FZF_COLOURS,pointer:#83c092" # Pointer: cyan
FZF_COLOURS="$FZF_COLOURS,info:#d3c6aa"    # Info elements: light grey
FZF_COLOURS="$FZF_COLOURS,border:#475258"  # Border: grey
export FZF_DEFAULT_OPTS="--color=$FZF_COLOURS"
