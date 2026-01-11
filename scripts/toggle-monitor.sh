#!/usr/bin/env bash

# Script that toggles a monitor on/off

# Monitor name
MONITOR="DP-2"

# Check if monitor is on/off and toggle
if wlr-randr | grep -A6 "$MONITOR" | grep "Enabled" | grep -q "yes"; then
    wlr-randr --output "$MONITOR" --off
else
    wlr-randr --output "$MONITOR" --on --preferred
fi
