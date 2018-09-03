#!/bin/bash

# Path:        ~/scr/gromit-launcher.sh
# Created:     03.09.18, 22:57    @x200
# Last update: 03.09.18, 23:35:08 @x200

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 
G_PID=$(ps aux | awk '/gromit-mpx/ && !/awk/ {print $2}')

if [[ $G_PID ]]; then
    kill -9 $G_PID
    pkill -RTMIN+14 i3blocks
    notify-send -u critical "Gromit:" "has been disabled"
else
    gromit-mpx &
    pkill -RTMIN+14 i3blocks
    notify-send -u low "Gromit:" "is now enabled!\nF9     - toggle draw\nShift  - blue\nCtrl   - yellow\nAlt    - erase\nF10    - undo\nwin+F8 - disable"
fi

# [[ $(ps aux | grep "gromit-mpx" | grep -v grep) ]] && 

# >> RUN:
# while getopts 'sk' flag; do
#     case "${flag}" in
#         s) gromit-mpx &
#            [[ $(ps aux | grep "gromit-mpx" | grep -v grep) ]] && pkill -RTMIN+14 i3blocks
#            ;;
#         k) kill -9 $G_PID
#            pkill -RTMIN+14 i3blocks
#            ;;
#     esac
# done
