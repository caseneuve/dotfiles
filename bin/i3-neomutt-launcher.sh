#!/bin/bash

# Path:        ~/.dotfiles/bin/nmt-i3launcher.sh
# Created:     20.05.18, 10:25    @lenovo
# Last update: 19.08.18, 02:53:39 @x200

# >> DOC:
# "Open neomutt @ws 10, if already running, just go there"

# >> TODOS:
# todo: zastąpić st-256clor zmienną dla terinala
# done: niech zawsze fokusuje się na neomutcie, gdy wchodzi do ws10 (alt: i3ipc/xdotool)

# >> VARIABLES:
APP=neomutt
#WS=$(i3-msg -t get_config | grep 'set \$ws10' | awk '{print $3 " " $4}')
WS=$(i3-msg -t get_config | grep 'set \$ws10' | awk '{print $4}')
NEOMUTT_ID=$(wmctrl -lx | grep "st-256color.st-256color" | grep $APP | grep -v grep | awk '{print $1}')

# >> RUN:
if [[ $(pidof $APP) ]]; then
    #i3-msg -q 'workspace 10'
    wmctrl -ia $NEOMUTT_ID
else
    print $WS
    i3-msg -q "workspace $WS; exec --no-startup-id st -e $APP"
fi

pkill -RTMIN+10 i3blocks

