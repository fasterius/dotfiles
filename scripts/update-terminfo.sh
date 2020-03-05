#!/bin/bash

# Update the terminfo database for italic fonts
cp -r ~/.bash/terminfo ~/.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux.terminfo
tic -o ~/.terminfo ~/.terminfo/tmux-256color.terminfo
tic -o ~/.terminfo ~/.terminfo/xterm-256color.terminfo
