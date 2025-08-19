#!/usr/bin/env bash

# A script to focus, cycle or launch an application in Niri.
#
# - If the app is not running, it launches a new app instance.
# - If the app is running but not focused, it focuses the app window.
# - If the app is running, is currently focused AND has multiple instances,
#   cycle through the different instances.
#
# Define key bindings in your Niri config that execute this script, for example:
#   Super+F { spawn "~/.config/niri/niri-run-or-raise.sh" "firefox"; }
#
# Dependencies:
# - bash: The script uses Bash arrays.
# - niri: The Wayland compositor this script is designed for.
# - jq:   A command-line JSON processor.

# Arguments
APP_CLASS="$1" # Application's app_id (e.g. firefox)
APP_CMD="$2"   # Command to run the application (e.g. firefox; optional)

# Check if the required arguments are provided, exit otherwise
if [ -z "$APP_CLASS" ] ; then
    notify-send -t 5000 "Usage: niri-run-or-raise.sh <APP_CLASS> <APP_CMD>"
    exit 1
fi

# Get the ID of the currently focused window
FOCUSED_ID=$(niri msg -j focused-window | jq -r '.id')

# Find windows matching the app class and read them into an array
readarray -t MATCHING_IDS < <(
    niri msg -j windows \
    | jq -r --arg app_class "$APP_CLASS" \
    '
        .[]
        | select(.app_id | ascii_downcase | contains($app_class | ascii_downcase))
        | .id
    '
)

# Launch the app and exit the script if the number of matching windows is zero
if [ ${#MATCHING_IDS[@]} -eq 0 ]; then
    # Use the app class as the command if no app command is supplied
    if [ -z "$APP_CMD" ]; then
        APP_CMD="$APP_CLASS"
    fi
    "$APP_CMD" &
    exit 0
fi

# Find the array index of the currently focused window
CURRENT_INDEX=-1
for INDEX in "${!MATCHING_IDS[@]}"; do
    if [ "${MATCHING_IDS[$INDEX]}" = "$FOCUSED_ID" ]; then
        CURRENT_INDEX=$INDEX
        break
    fi
done

# Cycle to the next matching array index if the currently focused ID was found
# in the array, otherwise set the target index to zero
if [ $CURRENT_INDEX -ge 0 ]; then
    TARGET_INDEX=$(( (CURRENT_INDEX + 1) % ${#MATCHING_IDS[@]} ))
else
    TARGET_INDEX=0
fi

# Switch focus to the target window stored in the array
niri msg action focus-window --id "${MATCHING_IDS[$TARGET_INDEX]}"
