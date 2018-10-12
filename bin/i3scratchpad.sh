#!/bin/bash

# Path:        ~/.dotfiles/bin/scratchpad.sh
# Created:     13.10.18, 01:19    @lenovo
# Last update: 13.10.18, 01:42:23 @lenovo

# >> DOC: 
# i3config helper: start tmux scratchpad if doesn't exist or show it

# >> VARIABLES:
term=st

# >> RUN:
if [[ ! $(ps aux | grep dropdown | grep -v grep) ]]
then
    i3-msg -q "exec --no-startup-id $term -c scratch -t dropdown -e ~/.dotfiles/bin/tmux-starter.sh" && sleep 0.05
fi

i3-msg -q "[title=\"dropdown\"] scratchpad show"
