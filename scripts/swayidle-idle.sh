#!/usr/bin/env bash

swayidle -w \
	timeout 600 '~/.dotfiles/scripts/swaylock-lock.sh' \
    timeout 900 'systemctl suspend' \
	before-sleep '~/.dotfiles/scripts/swaylock-lock.sh'
