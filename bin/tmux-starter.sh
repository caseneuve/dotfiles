#!/bin/bash

# Path:        ~/.tmux/tmux-hg.sh
# Created:     2018-03-13, 10:30    @x200
# Last update: 2019-08-20, 14:07:25 @x200
# Doc:         start tmux with apps: simple terminal window, weechat, ranger, calcurse, mocp, htop and neomutt
#              or attach to existing instance
# https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened

if [[ ! $(tmux ls | grep tmux ) ]]; then
    FZF_DEFAULT_OPTS='--height 100% --layout=default --inline-info --border --margin 1,5%'
    EDITOR='emacsclient -nw -s term'
    tmux new-session -s 'tmux' -d 'fish'
    tmux new-window -n 'wee' 'weechat'
    tmux new-window -n 'rng' 'ranger'
    tmux new-window -n 'cal' 'calcurse'
    tmux new-window -n 'mocp' 'mocp'
    tmux new-window -n 'mail' 'neomutt'
    tmux new-window -n 'htop' 'htop'
    tmux rename-window -t%0 'term'
    tmux select-window -t 'tmux:term'
    tmux splitw -h -p 20
    tmux clock-mode
fi

tmux -2 attach -d

