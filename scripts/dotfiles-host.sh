#!/usr/bin/env bash

# Host registry: facts detected about the current host, plus the per-host
# choices that can't be detected, used throughout dotfiles. Source it to get the
# `DOTFILES_*` variables below, or run it with the name of a single choice
# (`colourscheme`, `hpc` or `slow-fs`) to print its value. Unknown hosts get the
# defaults. Detection only uses Bash built-ins and file tests, as this is
# sourced at every shell start.

# ------------------------------- Detected facts -------------------------------

# Operating system, in lowercase (`darwin` or `linux`), as used in the names of
# OS-specific configs (`<name>-<os>.<ext>`)
case "$OSTYPE" in
    darwin*) DOTFILES_OS="darwin" ;;
    linux*)  DOTFILES_OS="linux" ;;
    *)       DOTFILES_OS="" ;;
esac

# Whether the host lacks a desktop (1) or not (0); Linux desktops install
# session files for their display manager, which servers and HPC systems lack
DOTFILES_HEADLESS=1
if [[ "$DOTFILES_OS" == "darwin" \
    || -d /usr/share/xsessions \
    || -d /usr/share/wayland-sessions ]]; then
    DOTFILES_HEADLESS=0
fi

# ---------------------------------- Choices -----------------------------------

DOTFILES_COLOURSCHEME="solarized"
DOTFILES_HPC=""     # HPC system whose `bash/<name>_profile` to load
DOTFILES_SLOW_FS=0  # 1 disables features that are slow on parallel filesystems

# Bash's `$HOSTNAME` avoids spawning `hostname`, which is slow on some systems
case "${HOSTNAME:-$(hostname)}" in
    sajberspace) DOTFILES_COLOURSCHEME="everforest" ;;
    *uppmax*)    DOTFILES_HPC="uppmax" ;;
    *login1*)    DOTFILES_SLOW_FS=1 ;;
esac

# PDC systems are recognised by their filesystem, as the hostnames of compute
# nodes differ from those of the login nodes
if [[ -z "$DOTFILES_HPC" && -d /cfs/klemming ]]; then
    DOTFILES_HPC="pdc"
fi

# When run instead of sourced, print the requested choice
if ! (return 0 2>/dev/null); then
    case "$1" in
        colourscheme) echo "$DOTFILES_COLOURSCHEME" ;;
        hpc)          echo "$DOTFILES_HPC" ;;
        slow-fs)      echo "$DOTFILES_SLOW_FS" ;;
        *)
            echo "Usage: ${0##*/} colourscheme|hpc|slow-fs" >&2
            exit 1
            ;;
    esac
fi
