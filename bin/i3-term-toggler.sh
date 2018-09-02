#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-term-toggler.sh
# Created:     02.09.18, 15:28    @lenovo
# Last update: 02.09.18, 16:01:40 @lenovo

# >> DOC: cycles throug visible terminals (classed "term")
# requires: xdotool

# >> TODOS: 

# >> VARIABLES: 
IDS+=$(xdotool search --class term)
FOC_ID=$(xdotool getactivewindow)
FOC_WS=$(xdotool get_desktop_for_window $FOC_ID)
declare -a WSS+=$(wmctrl -lx | awk '/st-256color.term/ {print $1}')
echo $IDS
echo ${#WSS[@]}
echo ${WSS[0]}
#xdotool windowraise $id

# >> RUN: 
if [[ -n $IDS ]]; then
    # >>   a. if focused window is emacs
    if [[ $(echo ${IDS[@]} | grep "$FOC_ID") ]]; then
        for ((i=0; i<len; i++)); do
            if [[ $FOC_ID == ${IDS[$i]} ]]; then
                # >>    a1. if there is only one emacs window on the list
                (( len == 1 )) &&\
                    notify-send -u low \
                                "i3" \
                                "<i>No other terminals opened</i>"
                # >>    a2. if focus is on the last emacs win on the list
                # - go to the beginning
                (( i + 1 < len )) && a=$((i+1)) || a=0
                xdotool windowraise ${IDS[$a]} && break
            fi
        done
    else
        # >>   b. if focused window is not emacs:
        #  - check if there is an emacs on the same wksp
        # if not, go to the first instance (probably GUI)
        for i in ${!WSS[*]}; do
            if [[ ${WSS[$i]} = $FOC_WS ]]; then
                xdotool windowraise ${IDS[$i]} && exit
            fi
        done
        xdotool windowraise ${IDS[0]}
    fi
else
    # >>  2. or run emacs
    st -c term &
fi
