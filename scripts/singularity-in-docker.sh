#!/bin/bash

# Script that runs the "Singularity in Docker" to build Singularity images from
# local Docker images (https://github.com/kaczmarj/singularity-in-docker). Input
# is a local Docker image as an argument to this script, which outputs a
# Singularity image file with the same name, plus the `.sif` extension.

# Check number of input arguments
if [ "$#" -ne 1 ]; then
    echo "Must provide exactly one input Docker image; aborting."
    exit 1
fi

# Get input Docker image
DOCKER_IMAGE=$1

# Convert to Singularity image
docker run \
    --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd):/work \
    kaczmarj/singularity:3.8.0 \
    build ${DOCKER_IMAGE}.sif docker-daemon://${DOCKER_IMAGE}:latest
