#!/bin/bash

#* ---------------------------------------
# Path:        ~/scr/mocp-poly.sh
# Created:     2019-06-05, 21:32    @x200
# Last update: 2019-11-24, 16:41:00 @lenovo
# Doc:         check mocp config and
#              OnSongChange property
#* ----------------------------------------

socket=/tmp/polybar-ipc-primary

while [ -e $socket ]; do
    case "$(mocp -Q %state)" in
        PLAY) echo hook:module/moc1 >> $socket;;
        PAUSE) echo hook:module/moc2 >> $socket ;;
        *) break ;;
    esac
    sleep 1
done

echo hook:module/moc3 >> $socket
exit
