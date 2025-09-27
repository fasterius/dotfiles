#!/bin/bash
TIMEOUT=1500
pactl subscribe | while read -r event; do
    if [[ "$event" == *"sink"* && "$event" == *"change"* ]]; then
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//' | head -n 1)
        MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        if [ "$MUTED" = "yes" ]; then
            TEXT="Muted"
        else
            TEXT="$VOLUME %"
        fi
        makoctl dismiss --all
        notify-send \
            -u low \
            -t "$TIMEOUT" \
            "Volume" "$TEXT"
    fi
done
