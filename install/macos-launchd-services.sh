#!/bin/bash

# Script that installs the launchd services in `launchd/` on MacOS. Uses an
# `@HOME@` placeholder for the home directory, as launchd can't expand
# variables, so the services are copied rather than symlinked; each is reloaded
# so that changes take effect. Safe to run multiple times.

# Check for MacOS
if [[ ! "$(uname)" == "Darwin" ]]; then
    echo "Not on MacOS; not installing launchd services"
    exit 0
fi

# Services to install, with the program each one requires
SERVICES=()
if command -v llama-server > /dev/null; then
    SERVICES+=(org.llama-cpp.server)

    # Create the server's API key outside of the repository, if missing
    API_KEY="$HOME/.local/share/llama.cpp/api-key"
    if [[ ! -f "$API_KEY" ]]; then
        echo "Creating llama.cpp API key in $API_KEY ..."
        mkdir -p "$(dirname "$API_KEY")"
        (umask 077 && openssl rand -hex 32 | tr -d '\n' > "$API_KEY")
    fi
fi
if command -v tailscaled > /dev/null; then
    SERVICES+=(com.tailscale.tailscaled-userspace)
    mkdir -p "$HOME/.local/state/tailscale"
fi

mkdir -p "$HOME/Library/LaunchAgents"

# Install and (re)load each service
for SERVICE in "${SERVICES[@]}"; do
    echo "Installing $SERVICE ..."
    PLIST="$HOME/Library/LaunchAgents/$SERVICE.plist"
    sed "s|@HOME@|$HOME|g" "$HOME/.dotfiles/launchd/$SERVICE.plist" > "$PLIST"
    launchctl bootout "gui/$(id -u)" "$PLIST" 2> /dev/null
    launchctl bootstrap "gui/$(id -u)" "$PLIST"
done
