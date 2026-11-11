#!/bin/bash

# Script source: https://github.com/GloriousEggroll/proton-ge-custom#native

set -euo pipefail
trap 'echo "Error" >&2' ERR

# Make a temporary working directory
echo "Making sure temporary directory exists..."
mkdir -p /tmp/proton-ge-custom
cd /tmp/proton-ge-custom

steam_dir=~/.steam/steam

# Verify Steam data directory exists
if [[ ! -d "$steam_dir" ]]; then
    echo "Error: Steam (native) data directory not found." >&2
    echo "Please launch Steam at least once to populate it." >&2
    exit 1
fi

# Make a Steam compatibility tools folder if it does not exist
mkdir -p "$steam_dir/compatibilitytools.d"

# Fetch release info
echo "Fetching release info..."
release_json=$(curl -s --max-time 10 \
    https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest)

if [[ -z "$release_json" || "$release_json" != *'"tag_name"'* ]]; then
    echo "Error: Failed to fetch release info from GitHub." >&2
    exit 1
fi

# Resolve release URL for current architecture
echo "Fetching release for your arch..."

case "$(uname -m)" in
    aarch64|arm64) tarball_pattern='\-aarch64\.tar\.gz$' ;;
    x86_64)        tarball_pattern='\-x86_64\.tar\.gz$' ;;
    *)
        echo "Error: Unsupported architecture: $(uname -m)." >&2
        echo "GE-Proton is only available for x86_64 and aarch64." >&2
        exit 1
        ;;
esac

tarball_url=$(echo "$release_json" |
    grep browser_download_url |
    cut -d\" -f4 |
    grep -E "$tarball_pattern" |
    head -n1 || true)

tarball_name=$(basename "$tarball_url")
release_name=${tarball_name%.tar.gz}

if [[ -z "$tarball_url" ]]; then
    echo "Error: Could not find a matching release for your arch ($(uname -m))." >&2
    exit 1
fi

# Skip if already installed
if [[ -d "$steam_dir/compatibilitytools.d/$release_name" ]]; then
    echo "Latest release $release_name is already installed."
    exit 0
fi

# Resolve checksum URL
checksum_url=$(echo "$release_json" |
    grep browser_download_url |
    cut -d\" -f4 |
    grep "$release_name.sha512sum$" || true)

if [[ -z "$checksum_url" ]]; then
    echo "Error: Could not find a checksum for $tarball_name in the release." >&2
    exit 1
fi

# Use cached tarball from tmp if valid, resume if incomplete
if [[ -f "$tarball_name" ]]; then
    echo "Found cached release: $release_name"
    echo "Verifying download..."

    if curl -sL "$checksum_url" | sha512sum -c - &>/dev/null; then
        echo "Cached release OK, skipping download."
    else
        echo "Cached release is incomplete, resuming download..."
        curl -C - -L "$tarball_url" -o "$tarball_name" --progress-bar
        echo "Verifying download..."

        if ! curl -sL "$checksum_url" | sha512sum -c - &>/dev/null; then
            echo "Resumed download corrupt, falling back to fresh download..."
            rm -f "$tarball_name"
            curl -L "$tarball_url" -o "$tarball_name" --progress-bar
            echo "Verifying download..."

            if ! curl -sL "$checksum_url" | sha512sum -c -; then
                echo "Error: Verification failed! The downloaded release may be corrupt." >&2
                exit 1
            fi
        fi
    fi

# Nuke the temporary working directory and download the tarball
else
    echo "Cleaning temporary directory..."
    rm -rf /tmp/proton-ge-custom
    mkdir /tmp/proton-ge-custom
    cd /tmp/proton-ge-custom
    echo "Downloading release: $release_name..."
    curl -L "$tarball_url" -o "$tarball_name" --progress-bar
    echo "Verifying download..."

    if ! curl -sL "$checksum_url" | sha512sum -c -; then
        echo "Error: Verification failed! The downloaded release may be corrupt." >&2
        exit 1
    fi
fi

# Extract the GE-Proton tarball to the Steam compatibility tools folder
echo "Extracting $tarball_name to the Steam compatibility tools folder..."
tar -xf "$tarball_name" -C "$steam_dir/compatibilitytools.d/" \
    || { echo "Error: Extraction failed!" >&2; exit 1; }

echo "Done :)"
