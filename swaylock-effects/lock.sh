#!/bin/sh

WALLPAPER="$HOME/Dropbox/wallpaper.jpg"

swaylock \
    --daemonize \
    --clock \
    --image "$WALLPAPER" \
    --scaling fill \
    --indicator \
    --indicator-caps-lock \
    --indicator-idle-visible \
    --inside-color 000000cc \
    --inside-ver-color 000000cc \
    --inside-wrong-color 000000cc \
    --ring-color 000000cc \
    --ring-ver-color 000000cc \
    --ring-wrong-color 000000cc \
    --line-color 000000cc \
    --line-ver-color 000000cc \
    --line-wrong-color 000000cc \
    --separator-color 000000cc \
    --text-color ffffffcc \
    --text-ver-color ffffffcc \
    --text-wrong-color ffffffcc \
    --effect-blur 7x5 \
    --effect-vignette 0.4:0.8 \
