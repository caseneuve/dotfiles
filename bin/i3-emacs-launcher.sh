#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-emacs-launcher.sh
# Created:     27.05.18, 09:16    @x200
# Last update: 02.09.18, 13:18:49 @lenovo

# >> DOC:
# "If emacs is running goes to the first workspace with qtb window; if not -- launches qtb at wksp 1"
# note: requires `wmctrl` package (pacman)

# >> TODOS:
# todo: spr. czy można to skrócić awkiem, żeby od razu zadeklarwać listy

# >> VARIABLES:
GUI_ID+=$(wmctrl -lx | awk '/emacs.Emacs/ && !/st-256color/ && !/qutebrowser.qutebrowser/ {print $1}')
GUI_WS+=$(wmctrl -lx | awk '/emacs.Emacs/ && !/st-256color/ && !/qutebrowser.qutebrowser/ {print $2}')
CLI_ID+=$(wmctrl -lx | grep "emacsclient\| e " | grep -v grep | awk '{print $1}')
CLI_WS+=$(wmctrl -lx | grep "emacsclient\| e " | grep -v grep | awk '{print $2}')
FOC_NAME=$(~/bin/i3get -n)
FOC_ID=$(wmctrl -l | grep "$FOC_NAME" | awk  '{print $1}')
FOC_WS=$(wmctrl -d | awk '/*/ {print $1}')

IDS=(${GUI_ID[@]} ${CLI_ID[@]})
WSS=(${GUI_WS[@]} ${CLI_WS[@]})
len=${#IDS[@]}

# >> RUN:
# 1. if emacs is running running
if [[ -n $IDS ]]; then
    # a. if focused window is emacs
    if [[ $(echo ${IDS[@]} | grep $FOC_ID) ]]; then
        for ((i=0; i<len; i++)); do
            if [[ $FOC_ID == ${IDS[$i]} ]]; then
                # a1. if there is only one emacs window on the list
                (( len == 1 )) &&\
                    notify-send -u low \
                                "i3" \
                                "<i>No more Emacs instances active</i>"
                # a2. if focus is on the last emacs win on the list
                # - go to the beginning
                (( i + 1 < len )) && a=$((i+1)) || a=0
                wmctrl -ia ${IDS[$a]} && break
            fi
        done
    else
        # b. if focused window is not emacs:
        #  - check if there is an emacs on the same wksp
        # if not, go to the first instance (probably GUI)
        for i in ${!WSS[*]}; do
            if [[ ${WSS[$i]} = $FOC_WS ]]; then
                wmctrl -ia ${IDS[$i]} && exit
            fi
        done
        wmctrl -ai ${IDS[0]}
    fi
else
    # 2. or run emacs
    emacs &
fi
