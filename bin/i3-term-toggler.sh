#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-term-toggler.sh
# Created:     02.09.18, 15:28    @lenovo
# Last update: 02.09.18, 20:47:19 @lenovo

# >> DOC: cycles through visible terminals (classed "term")
# requires: xdotool
# requires: wmctrl 

# >> TODOS: 
# todo: przepisać wszystko na wmctrl?

# >> VARIABLES: 
IDS=($(xdotool search --class term))
FOC_ID=$(xdotool getactivewindow)
FOC_WS=$(wmctrl -d | awk '/*/ {print $1}')
WSS=($(wmctrl -lx | awk '/st-256color.term/ {print $2}'))
len=${#IDS[@]}

# >> RUN: 
if [[ -n $IDS ]]; then
    # >>   a. if focused window is a term
    if [[ $(echo ${IDS[@]} | grep "$FOC_ID") ]]; then
        for ((i=0; i<len; i++)); do
            if [[ $FOC_ID == ${IDS[$i]} ]]; then
                # >>    a1. if there is only one term window on the list
                (( len == 1 )) && \
                    notify-send -u low \
                                "i3" \
                                "<i>No other terminals opened</i>"
                # >>    a2. if focus is on the last term win on the list
                # - go to the beginning
                (( i + 1 < len )) && a=$((i+1)) || a=0
                wmctrl -ia ${IDS[$a]} && break
            fi
        done
    else
        # >>   b. if focused window is not term:
        #  - check if there is an emacs on the same wksp
        # if not, go to the first instance
        for i in ${!WSS[*]}; do
            if [[ ${WSS[$i]} = $FOC_WS ]]; then
                wmctrl -ia ${IDS[$i]} && exit
            fi
        done
        wmctrl -ia ${IDS[0]}
    fi
else
    # >>  2. or run term
    st -c term &
fi
