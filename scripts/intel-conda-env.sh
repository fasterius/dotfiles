#!/usr/bin/env bash -l

# Script to create an Intel-based Conda environment on Apple Silicon hardware
# Input is a full Conda/Mamba command; can use both environment names and
# prefixes when specifying the environment, or from an environmen YAML file.
#
# Examples:
#   Conda create with a name
#   $ intel-conda-env.sh conda create -n my-env python=3.10
#
#   Mamba env create with prefix and custom YAML
#   $ intel-conda-env.sh mamba env create -p my-env -f my-env.yml
#
#   Mamba env create with name inside default YAML (environment.yml)
#   $ intel-conda-env.sh mamba env create

# Create a new Intel-based Conda environment
CONDA_SUBDIR=osx-64 "$@"

# Abort if specified command failed
if [ $? -gt 0 ]; then
    exit 1
fi

# Get the name of the environment from the command
ENV_NAME=$(echo $@ | tr ' ' '\n' | grep -A1 "\-n\|\-\-name\|\-p\|\-\-prefix") && \
    ENV_NAME=$(echo $ENV_NAME | cut -d ' ' -f 2)

# Get the name of the environment from an environment YAML file if neither name
# nor prefix was specified in the command
if [ $? -eq 1 ]; then

    # Get environment YAML name from command
    ENV_YAML=$(echo $@ | tr ' ' '\n' | grep -A1 "\-f\|\-\-file") && \
        ENV_YAML=$(echo $ENV_YAML | cut -d ' ' -f 2)

    # Use default environment YAML name if command does not specify it
    if [ $? -eq 1 ]; then
        ENV_YAML="environment.yml"
    fi

    # Get the environment name from the environment YAML
    ENV_NAME=$(head -1 $ENV_YAML | cut -d ' ' -f 2)
fi

# Get the full path of the environment, so that it may be activated in the same
# way regardless of whether it was created using a name or a prefix
ENV_PATH=$(conda env list \
    | grep $ENV_NAME \
    | tr -s ' ' \
    | cut -d ' ' -f 2)

# Configure subsequent Conda commands to use Intel-based packages
conda activate $ENV_PATH
conda config --env --set subdir osx-64
conda deactivate
