#!/usr/bin/env bash

swayidle -w \
	timeout 300 '~/.dotfiles/scripts/swaylock-lock.sh' \
    timeout 600 'wlopm --off *' \
        resume 'wlopm --on *' \
	before-sleep '~/.dotfiles/scripts/swaylock-lock.sh'
