#!/usr/bin/env bash

# Script for listing and selecting Tmux sessions using fzf-tmux in a pop-up
# window (requires Tmux version 3.2 or above)

# List Tmux session names
SESSIONS=$(tmux list-sessions -F "#S: #{session_name}" | cut -d ':' -f 1)

# Calculate the fzf window height based on the number of Tmux sessions plus
# the four lines coming from fzf-tmux elements, with a minimum height, without
# exceeding the terminal's height
MIN_HEIGHT=7
SESSION_COUNT=$(echo "$SESSIONS" | wc -l)
FZF_HEIGHT=$((SESSION_COUNT + 4 < MIN_HEIGHT ? MIN_HEIGHT : SESSION_COUNT + 4))
FZF_HEIGHT=$((FZF_HEIGHT > $(tput lines) ? $(tput lines) : FZF_HEIGHT))

# Calculate the fzf window width based on the length of the longest session name
# plus the six lines coming from fzf-tmux elements, with a minimum width
MIN_WIDTH=25
MAX_LENGTH=$(echo "$SESSIONS" | awk '{print length($1)}' | sort -nr | head -1)
FZF_WIDTH=$((MAX_LENGTH + 6 < MIN_WIDTH ? MIN_WIDTH : MAX_LENGTH + 6))

# Solarized colours for fzf-tmux
COLOURS="hl:#268BD2"               # Highlight: blue
COLOURS="$COLOURS,fg:#93A1A1"      # Foreground: light grey
COLOURS="$COLOURS,bg:#FDF6E3"      # Foreground: white
COLOURS="$COLOURS,fg+:#586E75"     # Selected foreground: grey
COLOURS="$COLOURS,bg+:#EEE8D5"     # Selected background: dark white
COLOURS="$COLOURS,hl+:#2AA198"     # Selected highlight: cyan
COLOURS="$COLOURS,prompt:#268BD2"  # Prompt: blue
COLOURS="$COLOURS,pointer:#2AA198" # Pointer: cyan
COLOURS="$COLOURS,info:#93A1A1"    # Info elements: light grey
COLOURS="$COLOURS,border:#657B83"  # Border: grey

# Run fzf-tmux with appropriate settings
TARGET_SESSION=$(echo "$SESSIONS" | fzf-tmux \
    -p $FZF_WIDTH,$FZF_HEIGHT \
    --color=$COLOURS \
    --reverse
)

# Switch to the selected session if selection was completed
if [ -n "$TARGET_SESSION" ]; then
    tmux switch-client -t "$TARGET_SESSION"
fi
