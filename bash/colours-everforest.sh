#!/usr/bin/env bash

# Everforest (dark) colours for fzf
FZF_COLOURS="hl:#83c092"                   # Highlight: aqua
FZF_COLOURS="$FZF_COLOURS,fg:#d3c6aa"      # Foreground: light grey
FZF_COLOURS="$FZF_COLOURS,bg:#272e33"      # Background: dark grey
FZF_COLOURS="$FZF_COLOURS,hl+:#83c092"     # Selected highlight: aqua
FZF_COLOURS="$FZF_COLOURS,fg+:#d3c6aa"     # Selected foreground: light grey
FZF_COLOURS="$FZF_COLOURS,bg+:#475258"     # Selected background: grey
FZF_COLOURS="$FZF_COLOURS,prompt:#83c092"  # Prompt: aqua
FZF_COLOURS="$FZF_COLOURS,pointer:#83c092" # Pointer: aqua
FZF_COLOURS="$FZF_COLOURS,info:#d3c6aa"    # Info elements: light grey
FZF_COLOURS="$FZF_COLOURS,border:#475258"  # Border: grey
export FZF_DEFAULT_OPTS="--color=$FZF_COLOURS"

# Theme for bat (`ansi` uses the terminal's own Everforest palette)
export BAT_THEME="ansi"
