#!/usr/bin/env bash

# Solarized light colours for fzf
FZF_COLOURS="hl:#268BD2"                   # Highlight: blue
FZF_COLOURS="$FZF_COLOURS,fg:#93A1A1"      # Foreground: light grey
FZF_COLOURS="$FZF_COLOURS,bg:#FDF6E3"      # Foreground: white
FZF_COLOURS="$FZF_COLOURS,hl+:#2AA198"     # Selected highlight: cyan
FZF_COLOURS="$FZF_COLOURS,fg+:#586E75"     # Selected foreground: grey
FZF_COLOURS="$FZF_COLOURS,bg+:#EEE8D5"     # Selected background: dark white
FZF_COLOURS="$FZF_COLOURS,prompt:#268BD2"  # Prompt: blue
FZF_COLOURS="$FZF_COLOURS,pointer:#2AA198" # Pointer: cyan
FZF_COLOURS="$FZF_COLOURS,info:#93A1A1"    # Info elements: light grey
FZF_COLOURS="$FZF_COLOURS,border:#657B83"  # Border: grey
export FZF_DEFAULT_OPTS="--color=$FZF_COLOURS"
