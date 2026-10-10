#!/usr/bin/env bash

# Common script for printing the colour scheme based on hostname, used
# throughout dotfiles for specifying colours.

case "$(hostname)" in
    sajberspace) echo "everforest" ;;
    *)           echo "solarized"  ;;
esac
