#!/usr/bin/env bash

# Set the NIRI_SOCKET environment variable to the socket of the most recently
# started Niri instance. Niri sets this itself for the programs it starts, but
# shells that weren't started by the current Niri instance (e.g. in a Tmux
# server that outlived a Niri restart) can have a missing or stale value.
#
# Must be sourced (not executed) to affect the current shell. Only uses Bash
# built-ins, as it runs every time a shell starts.

_NIRI_NEWEST=""
for _NIRI_SOCKET in "/run/user/$UID"/niri.*.sock; do
    if [[ -S "$_NIRI_SOCKET" ]] \
        && [[ -z "$_NIRI_NEWEST" || "$_NIRI_SOCKET" -nt "$_NIRI_NEWEST" ]]; then
        _NIRI_NEWEST="$_NIRI_SOCKET"
    fi
done
if [[ -n "$_NIRI_NEWEST" ]]; then
    export NIRI_SOCKET="$_NIRI_NEWEST"
fi
unset _NIRI_SOCKET _NIRI_NEWEST
