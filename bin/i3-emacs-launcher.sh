#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-emacs-launcher.sh
# Created:     27.05.18, 09:16    @x200
# Last update: 02.09.18, 00:32:16 @lenovo

# >> DOC:
# "If emacs is running goes to the first workspace with qtb window; if not -- launches qtb at wksp 1"
# note: requires `wmctrl` package (pacman)

# >> VARIABLES:
GUI_ID=$(wmctrl -lx | awk '/emacs.Emacs/ && !/st-256color/ {print $1}')
CLI_ID=$(wmctrl -lx | grep "emacsclient\| e " | grep -v grep | awk '{print $1}')
IDS=($GUI_ID $CLI_ID)
len=${#IDS[@]}
FOC_NAME=$(~/bin/i3get -n)
FOC_ID=$(wmctrl -l | grep "$FOC_NAME" | awk  '{print $1}')

# >> RUN
if [[ -n $IDS ]]; then
    if [[ $(echo ${IDS[@]} | grep $FOC_ID) ]]; then
        for ((i=0; i<len; i++)); do
            if [[ $FOC_ID == ${IDS[$i]} ]]; then
                (( len == 1 )) && notify-send "No more Emacs instances active"; break 
                (( i + 1 < len )) && a=$((i+1)) || a=0
                wmctrl -ia ${IDS[$a]} && break
            fi
        done
    else
        wmctrl -ai ${IDS[0]}
    fi
else
    emacs &
fi
