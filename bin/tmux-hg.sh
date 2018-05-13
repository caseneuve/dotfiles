#!/bin/bash

# Path:        ~/.tmux/tmux-hg.sh
# Created:     13.03.18, 10:30    @x200
# Last update: 13.05.18, 21:22:51 @x200

# Doc: starts tmux with 3 windows, the second one named "hg" with HANGUPS and the third "cal" with CALCURSE running
# https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened

tmux new-session -s 'tmux' -d 
tmux new-window -n 'hg' 'hangups'
tmux new-window -n 'cal' 'calcurse'
tmux select-window -t 'tmux:cal'
tmux -2 attach -d

