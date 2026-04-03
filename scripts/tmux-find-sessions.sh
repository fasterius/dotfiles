#!/usr/bin/env bash

# Script for listing and selecting Tmux sessions in a pop-up window.
# Requires Tmux version 3.2 or above.
#
# Usage:
#   $ tmux-find-sessions.sh
#
# Example keybind in `tmux.conf`:
#   $ bind-key f run-shell tmux-find-sessions.sh

# List session names
SESSIONS=$(tmux list-sessions -F "#{session_name}")

# Calculate the popup window height based on the number of Tmux sessions plus
# the four lines coming from the popup elements, with a minimum height, without
# exceeding the terminal's height
MIN_HEIGHT=7
MAX_HEIGHT=$(printf "%s\n" "$SESSIONS" | wc -l)
POPUP_HEIGHT=$((MAX_HEIGHT + 4 < MIN_HEIGHT ? MIN_HEIGHT : MAX_HEIGHT + 4))
POPUP_HEIGHT=$((POPUP_HEIGHT > $(tput lines) ? $(tput lines) : POPUP_HEIGHT))

# Calculate the popup window width based on the length of the longest session
# name plus the six lines coming from the popup elements, with a minimum width
MIN_WIDTH=25
MAX_WIDTH=$(printf "%s\n" "$SESSIONS" | wc -L)
POPUP_WIDTH=$((MAX_WIDTH + 6 < MIN_WIDTH ? MIN_WIDTH : MAX_WIDTH + 6))

# Build the popup
tmux display-popup \
    -w "$POPUP_WIDTH" \
    -h "$POPUP_HEIGHT" \
    -E "tmux list-sessions -F '#{session_name}' | \
        fzf --reverse | \
        xargs -I {} tmux switch-client -t {}"
