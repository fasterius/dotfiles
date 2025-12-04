#!/bin/bash

# Volume control script with notifications
#
# This script adjusts your system volume and shows a Mako notification
# with a graphical volume bar.
#
# Usage:
#   volume-control.sh up       - Increase volume by 10%
#   volume-control.sh down     - Decrease volume by 10%
#   volume-control.sh mute     - Toggle mute on/off

# Notification timeout
TIMEOUT=1500

# Volume bar helper
vol_bar() {
    local vol=$1
    local blocks=$((vol / 10))
    local bar=""
    for i in $(seq 1 10); do
        if [ $i -le $blocks ]; then
            bar+="█"
        else
            bar+="░"
        fi
    done
    echo "$bar"
}

# Perform action
case "$1" in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +10%
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -10%
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac

# Read current state
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//' | head -n 1)
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Get icons for current state
BAR=$(vol_bar "$VOL")

# Get text for current state
if [ "$MUTED" = "yes" ]; then
    TEXT="Muted"
else
    TEXT="$VOL% $BAR"
fi

# Send notification
makoctl dismiss --all
notify-send -u low -t "$TIMEOUT" "Volume" "$TEXT"
