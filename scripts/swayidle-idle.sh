#!/usr/bin/env bash

swayidle -w \
	timeout 300 '~/.dotfiles/swaylock-effects/lock.sh' \
    timeout 600 'wlopm --off *' \
        resume 'wlopm --on *' \
	before-sleep '~/.dotfiles/swaylock-effects/lock.sh'
