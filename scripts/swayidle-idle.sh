#!/usr/bin/env bash

swayidle -w \
	timeout 300 '~/.dotfiles/scripts/swaylock-lock.sh' \
    timeout 600 'systemctl suspend' \
	before-sleep '~/.dotfiles/scripts/swaylock-lock.sh'
