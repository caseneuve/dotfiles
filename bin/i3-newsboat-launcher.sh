#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-newsboat-launcher.sh
# Created:     16.08.18, 19:08    @x200
# Last update: 16.08.18, 20:32:36 @x200

# >> DOC:
# note: requires `wmctrl`
# "focus newsboat or start one"

# >> VARIABLES:
NEWSBOAT_ID=$(wmctrl -lx | grep "st-256color.st-256color" | awk '{print $5 " " $1}' | grep newsboat | awk '{print $2}')

# >> RUN: 
if [[ $(pidof newsboat) ]]; then
    #i3-msg -q 'workspace 10'
    wmctrl -ia $NEWSBOAT_ID
else
    i3-msg -q 'workspace 10; exec --no-startup-id st -e newsboat'
fi

