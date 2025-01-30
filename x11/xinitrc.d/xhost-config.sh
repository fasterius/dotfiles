#!/bin/sh

# Configuration for Xorg/X11, for use when wanting to display e.g. plots from
# within a Docker container (which requires XQuartz to function); used by
# `docker-X11-interactive.sh` script in this repository.

xhost +localhost
xhost +\$(hostname)
