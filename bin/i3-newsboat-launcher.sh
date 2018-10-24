#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-newsboat-launcher.sh
# Created:     16.08.18, 19:08    @x200
# Last update: 25.10.18, 01:07:54 @lenovo

# >> DOC:
# note: requires `wmctrl`
# "focus newsboat or start one"
# start terminal classed: rss

# >> VARIABLES:
APP=newsboat
#WS=$(i3-msg -t get_config | grep 'set \$ws10' | awk '{print $3 " " $4}')
#WS=$(i3-msg -t get_config | grep 'set \$ws10' | awk '{print $4}')
NEWSBOAT_ID=$(wmctrl -lx | grep "st-256color.rss" | awk '{print $5 " " $1}' | grep $APP | awk '{print $2}')

# >> RUN: 
if [[ $(pidof $APP) ]]; then
    #i3-msg -q 'workspace 10'
    wmctrl -ia $NEWSBOAT_ID
else
    #i3-msg -q "workspace $WS; exec --no-startup-id st -c rss -e $APP"
    i3-msg -q "exec --no-startup-id st -c rss -e $APP"
fi

