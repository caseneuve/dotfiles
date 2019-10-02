#!/bin/bash

#* ---------------------------------------
# Path:        ~/scr/mocp-poly.sh
# Created:     2019-06-05, 21:32    @x200
# Last update: 2019-10-02, 08:36:50 @lenovo
# Doc:         check mocp config and
#              OnSongChange property
#* ----------------------------------------

file="$(mocp -Q %file)"
socket=/tmp/polybar-ipc-primary

if ! [[ $file == "" ]]; then
    while [[ $(mocp -Q %file) == "$file" ]]
    do
        if [[ $(mocp -Q %state) == PLAY ]]; then
            echo hook:module/moc1 >> $socket
            prev=PLAY
            sleep 1
        elif ! [[ $prev == PAUSE ]]; then
            echo hook:module/moc2 >> $socket
            prev=PAUSE
        fi
    done
fi

[[ $(mocp -Q %state) == STOP ]] && echo hook:module/moc3 >> $socket
exit
