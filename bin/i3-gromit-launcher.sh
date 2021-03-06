#!/bin/bash

# Path:        ~/scr/gromit-launcher.sh
# Created:     03.09.18, 22:57    @x200
# Last update: 29.10.18, 20:21:24 @lenovo

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 
#G_PID=$(ps aux | awk '/gromit-mpx/ && !/awk/ {print $2}')
G_PID=$(pgrep gromit-mpx)

if [[ $G_PID ]]; then
    kill -9 $G_PID
    pkill -RTMIN+14 i3blocks
    notify-send -u critical "Gromit:" "has been disabled"
else
    gromit-mpx -a &
    pkill -RTMIN+14 i3blocks
    notify-send -u low "Gromit:" "is now enabled!\nF9     - toggle draw\nShift  - blue\nCtrl   - yellow\nAlt    - erase\nF10    - undo\nwin+F8 - disable"
fi
