#!/usr/bin/env bash

# Set the NIRI_SOCKET environment variable automatically

SOCKET=$(find /run/user/$UID -name 'niri*sock' 2> /dev/null | head -n 1)
if [ -n "$SOCKET" ]; then
    export NIRI_SOCKET="$SOCKET"
fi
