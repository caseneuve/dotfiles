#!/bin/bash

# Path:        ~/.dotfiles/bin/nmt-i3launcher.sh
# Created:     20.05.18, 10:25    @lenovo
# Last update: 15.08.18, 00:47:26 @x200

# >> DOC:
# "Open neomutt @ws 10, if already running, just go there"

# >> TODOS:
# todo: zastąpić st-256clor zmienną dla terinala
# done: niech zawsze fokusuje się na neomutcie, gdy wchodzi do ws10 (alt: i3ipc/xdotool)

NEOMUTT_ID=$(wmctrl -lx | grep "st-256color.st-256color" | grep neomutt | grep -v grep | awk '{print $1}')

if [[ $(pidof neomutt) ]]; then
    #i3-msg -q 'workspace 10'
    wmctrl -ia $NEOMUTT_ID
else
    i3-msg -q 'workspace 10; exec --no-startup-id st -e neomutt'
fi

pkill -RTMIN+10 i3blocks

