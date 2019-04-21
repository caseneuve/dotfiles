#!/bin/bash

# Path:        ~/biu/bash/cdemacsdir.sh
# Created:     26.08.18, 15:00    @x200
# Last update: 2019-04-21, 19:36:42 @x200
# Doc:
# Requires:
# - i3get.py → git: py-exercises (26/08/2018)
# - i3ipc as dep.
# - wmctrl
# If an Emacs window is focused with a file in active buffer,
# open the terminal in the working directory; 
# else, open in $HOME.

[[ -z $GOTPATH ]] && GOPATH=$HOME/go
GET=$GOPATH/bin/i3getgo

if [[ $($GET -c) =~ "Emacs" ]]; then
    FULL=$($GET -t)
    FILE=$(basename "$FULL")
    DIR=${FULL%$FILE}
    [[ -d $DIR ]] && cd $DIR
    st -c term -t "st @$(date +%H:%M:%S)" &
else
    cd $HOME
    st -c term -t "st @$(date +%H:%M:%S)" &
fi
