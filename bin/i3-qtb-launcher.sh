#!/bin/bash

# Path:        ~/.dotfiles/bin/qtb-launcher.sh
# Created:     26.05.18, 23:42    @x200
# Last update: 15.08.18, 14:05:07 @x200

# >> DOC:
# "If qutebrowser is running go to the next workspace with qtb window; if not -- launches qtb at wksp 2"

# >> TODOS:
# fixme: jak iść do następnego okna, a nie skakać między dwoma, jeśli jest więcej niż 2?
# done: przepisać to na py (i3ipc) albo użyć wmctrl

# >> VARIABLES:
QTB=$(wmctrl -lx | grep "qutebrowser.qutebrowser" | grep -v grep)
# note: additional paren is needet to capture output as an array!
QTB_ID=($(wmctrl -lx | awk '/qutebrowser.qutebrowser/ && !/st-256color/ {print $1}'))
[[ $QTB ]] && QTB_WS=($(wmctrl -lx | awk '/qutebrowser.qutebrowser/ && !/st-256color/ {print $2}'))

#declare -A QTB_DICT
n=0
for i in "${QTB_WS[@]}"; do
    QTB_DICT+=( ["$i"]="${QTB_ID[n]}" )
    n=$((n+1))
done

FOCUSED_WS=$(wmctrl -d | awk '/*/ {print $1}')
QTB_WS=($(echo ${QTB_WS[@]} | tr " " "\n" | sort -n))

# >> RUN:
if [[ $QTB ]]; then
    if [[ ${#QTB_WS[@]} > 1 ]]; then
        for ws in "${QTB_WS[@]}"; do
            # if focused = highest in the list, open the first from the list
            [[ $FOCUSED_WS == ${QTB_WS[-1]} ]] && wmctrl -ia ${QTB_DICT[${QTB_WS[0]}]} && break 
            # if focused is higher or equal than the list element, go next 
            [[ $ws < $FOCUSED_WS || $FOCUSED_WS == $ws ]] && continue
            wmctrl -ia ${QTB_DICT[$ws]} && break
        done
    else
        [[ $FOCUSED_WS == $QTB_WS ]] && \
            notify-send -u low "i3" "<i>No qutebrowser windows on other workspaces</i>" \
                        || wmctrl -ia ${QTB_ID}
    fi
else
    i3-msg -q "workspace 2; exec --no-startup-id qutebrowser"
fi

# >> SPADY:
#ws=$(i3-msg -t get_tree | grep -oE "num\":[0-9]*||qutebrowser" | tr "\n" " " | grep -o "num\":[0-9]* qutebrowser" | grep -o [0-9]* | head -n 1)
#[[ "$ws" ]] && i3-msg "workspace $ws" || i3-msg "workspace 2; exec --no-startup-id qutebrowser"

# >> TESTS:
# for i in "${!QTB_DICT[@]}"; do
#     echo "$i - ${QTB_DICT[$i]}"
# done
#echo $FOCUSED_WS

