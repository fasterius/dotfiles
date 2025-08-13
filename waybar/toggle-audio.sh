#!/bin/bash

# Script to toggle between two audio sources

# Define audio sources (list with `pactl list short sinks`)
HEADPHONES="alsa_output.usb-SteelSeries_SteelSeries_Arctis_7-00.stereo-game"
SPEAKERS="alsa_output.pci-0000_00_1f.3.analog-stereo"

# Get the current source
CURRENT_SINK=$(pactl get-default-sink)

# Define new sink
if [ "$CURRENT_SINK" = "$HEADPHONES" ]; then
    NEW_SINK="$SPEAKERS"
else
    NEW_SINK="$HEADPHONES"
fi

# Switch between sources and move current audio streams to the new sink
pactl set-default-sink "$NEW_SINK"
pactl list short sink-inputs | while read -r INPUT; do
    pactl move-sink-input $(echo $INPUT | cut -f1) "$NEW_SINK" 2> /dev/null
done
