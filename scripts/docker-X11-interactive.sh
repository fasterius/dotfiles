#!/bin/bash

# Script for starting an interactive Docker container with X11 forwarding,
# allowing graphical output to be displayed from within the container, such as
# when using a REPL. The current working directory is automatically mounted.
#
# An image name is the only required argument to this script, but extra options
# can be provided if needed. The default options that the container is run with
# include being ephemeral (`--rm`) and using a pseudo-terminal (`--tty`), so
# those are not needed as extra options. The REPL you want to run is a good
# final argument, e.g. `R` or `python`.
#
# Requires XQuartz to be installed and that the `xhost-config.sh` config file
# from this repo is moved/symlinked to `~/.xinitrc.d/xhost-config.sh`
#
# Usage:
#   docker-X11-interactive.sh [OPTIONS] IMAGE [ARG...]
#
# Example usage:
#   docker-X11-interactive.sh

# Check for input arguments
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: docker-X11-interactive.sh [OPTIONS] IMAGE [ARG...]"
    exit 1
fi
SCRIPT_ARGUMENTS="$@"

# Open XQuartz if it's not running
if ! ps aux | grep XQuartz | grep -vq grep; then
    open -a XQuartz
fi

# Start container
docker run \
    --rm \
    --tty \
    --interactive \
    --env DISPLAY=docker.for.mac.host.internal:0 \
    --workdir /work \
    --volume $(pwd):/work \
    ${SCRIPT_ARGUMENTS}
