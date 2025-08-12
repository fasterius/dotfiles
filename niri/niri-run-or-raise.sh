#!/usr/bin/env bash

#
# A script to intelligently focus or launch an application in niri.
# Designed to be used with keybindings.
#
# - If the app is not running, it launches a new instance.
# - If the app is running but not focused, it focuses the most recently used window.
# - If 'allow_multi' is 'yes' AND the app is already focused, it launches a new instance.
#
# Dependencies:
# - niri: The Wayland compositor this script is designed for.
# - jq: A command-line JSON processor.

# Arguments
APP_CLASS="$1"     # Application's app_id (e.g. firefox)
APP_CMD="$2"       # Command to run the application (e.g. firefox; optional)

# Check if required arguments are provided
if [ -z "$APP_CLASS" ] ; then
    notify-send -t 5000 "Usage: niri-run-or-raise.sh <APP_CLASS> <APP_CMD>"
    exit 1
fi

# Get info about the focused window and existing windows
FOCUSED_ID=$(niri msg -j focused-window | jq -r '.id')

# Find the ID of the last window matching the app_class.
# This is assumed to be the most recently used one.
ALL_MATCHING_IDS=$(\
    niri msg -j windows \
    | jq -r --arg app_class "$APP_CLASS" \
    '
        .[]
        | select(.app_id | ascii_downcase | contains($app_class | ascii_downcase))
        | .id
    '
)
MATCHING_ID=$( \
    printf '%s\n' "$ALL_MATCHING_IDS" \
    | head -n 1
)

# # Get first and last matching ID
# NEWEST_MATCH=$( \
#     printf '%s\n' "$ALL_MATCHING_IDS" \
#     | sort -r \
#     | head -n 1
# )
# OLDEST_MATCH=$( \
#     printf '%s\n' "$ALL_MATCHING_IDS" \
#     | sort -r \
#     | tail -n 1
# )

# Run or raise, as applicable
if [ -z "$ALL_MATCHING_IDS" ]; then

    # Set app command to app class if not specified
    if [ -z "$APP_CMD" ]; then
        APP_CMD="$APP_CLASS"
    fi
    bash -c "$APP_CMD" &

# elif [ "$FOCUSED_ID" = "$APP_CLASS" ]; then
    # $APP_CMD &

else
    # Focus app with matching ID
    niri msg action focus-window --id "$MATCHING_ID"
fi
