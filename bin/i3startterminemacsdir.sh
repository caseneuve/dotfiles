#!/bin/bash

# Path:        ~/biu/bash/cdemacsdir.sh
# Created:     26.08.18, 15:00    @x200
# Last update: 30.10.18, 10:38:51 @x200


# >> DOC:
# Requires:
# - i3get.py → git: py-exercises (26/08/2018)
# - i3ipc as dep.
# - wmctrl
# If an Emacs window is focused with a file in active buffer,
# open the terminal in the working directory; 
# else, open in $HOME.


# >> VARIABLES:
FULL=$(wmctrl -lx | awk '/emacs.Emacs/ {print $5}')
FILE=$(basename "$FULL")
DIR=${FULL%$FILE}
FOC=$(~/git/hub/i3/i3get.sh -c)

# >> RUN:
if [[ $FOC =~ "Emacs" && -d $DIR ]]; then
    cd $DIR && st -c term -t "st @$(date +%H:%M:%S)" &
else
    st -c term -t "st @$(date +%H:%M:%S)" &
fi
