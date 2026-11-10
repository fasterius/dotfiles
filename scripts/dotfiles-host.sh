#!/usr/bin/env bash

# Host registry: the per-host choices that can't be detected, used throughout
# dotfiles. Source it to get the `DOTFILES_*` variables below, or run it with
# the name of a single setting (`colourscheme`, `hpc` or `slow-fs`) to print its
# value. Unknown hosts get the defaults.

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

# When run instead of sourced, print the requested setting
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
