#!/bin/bash

# Script for installing Python and Vim so that the YouCompleteMe and UltiSnips
# Vim plugins will work on Uppmax

# Create `~/opt` directory (if non-existing)
mkdir -p ~/opt

# Install Python 3 if `$HOME/opt/python3/` directory doesn't exist
if [ ! -d "$HOME/opt/python3/" ]; then

    # Download Python
    cd ~/opt
    PY_VERSION=3.9.2
    wget https://www.python.org/ftp/python/$PY_VERSION/Python-$PY_VERSION.tgz
    tar -zxvf Python-$PY_VERSION.tgz
    cd Python-$PY_VERSION

    # Configure and install Python
    ./configure --prefix="$HOME/opt"
    make
    make install

    # Verify Python installation
    cd ..
    rm -rf Python-$PY_VERSION Python-$PY_VERSION.tgz
    ~/opt/python3/bin/python3 --version
    if [ $? != 0 ]; then
        echo "Error: Python installation failed"
        exit 1
    fi
fi

# Install Vim if `$HOME/opt/vim/` directory doesn't exist
if [ ! -d "$HOME/opt/vim/" ]; then

    # Download Vim
    cd ~/opt
    git clone https://github.com/vim/vim.git vim-source
    cd vim-source

    # Configure and install Vim
    ./configure \
        --with-features=huge \
        --enable-cscope \
        --enable-largefile \
        --enable-python3interp=yes \
        --with-python3-config-dir="$HOME/opt/python3/lib" \
        --prefix="$HOME/opt/vim"
    make
    make install
    cd ..
    rm -rf vim-source

    # Verify Vim installation
    ~/opt/vim/bin/vim --version
    if [ $? != 0 ]; then
        echo "Error: Vim installation failed"
        exit 1
    fi
fi
