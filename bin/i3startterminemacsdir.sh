#!/bin/bash

# Path:        ~/biu/bash/cdemacsdir.sh
# Created:     26.08.18, 15:00    @x200
# Last update: 26.08.18, 16:56:56 @x200

# >> DOC:
# If an Emacs window is focused with a file in active buffer,
# open the terminal in the working directory; 
# else, open in $HOME.

# >> VARIABLES:
FULL=$(wmctrl -lx | awk '/emacs.Emacs/ {print $5}')
FILE=$(basename "$FULL")
DIR=${FULL%$FILE}
FOC=$(~/bin/i3move -i | awk '/Class:/ {print $2}')

# >> RUN:
if [[ $FOC == 'Emacs' && -d $DIR ]]; then
    cd $DIR && st -t "st @$(date +%H:%M:%S)" &
else
    st -t "st @$(date +%H:%M:%S)" &
fi

