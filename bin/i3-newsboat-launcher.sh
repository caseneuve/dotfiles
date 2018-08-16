#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-newsboat-launcher.sh
# Created:     16.08.18, 19:08    @x200
# Last update: 16.08.18, 21:53:38 @x200

# >> DOC:
# note: requires `wmctrl`
# "focus newsboat or start one"

# >> VARIABLES:
APP=newsboat
WS=$(i3-msg -t get_config | grep 'set \$ws10' | awk '{print $3 " " $4}')
NEWSBOAT_ID=$(wmctrl -lx | grep "st-256color.st-256color" | awk '{print $5 " " $1}' | grep $APP | awk '{print $2}')

# >> RUN: 
if [[ $(pidof $APP) ]]; then
    #i3-msg -q 'workspace 10'
    wmctrl -ia $NEWSBOAT_ID
else
    i3-msg -q "$WS; exec --no-startup-id st -e $APP"
fi

