#!/bin/bash

# Path:        ~/.tmux/tmux-hg.sh
# Created:     13.03.18, 10:30    @x200
# Last update: 13.03.18, 10:44:50 @x200

# Doc: starts tmux with 2 windows, the second one named "hg" with hangups running
# https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened

tmux new-session -d 
tmux new-window -n 'hg' 'hangups' 
tmux -2 attach -d

