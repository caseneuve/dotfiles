#!/bin/bash

#* Path:        ~/.dotfiles/bin/i3startterminemacsdir.sh
#  Created:     26.08.18, 15:00    @x200
#  Last update: 2019-05-08, 12:08:20 @lenovo
#  Doc:         If an Emacs window is focused with a file in active buffer,
#               open the terminal in the working directory; 
#               else, open in $HOME.
#* Requires:    i3getgo
#* Code:

[[ -n $1 ]] && EXEC="-e $1" || EXEC=

[[ -z $GOBIN ]] && GOBIN=$HOME/go/bin
GET=$GOBIN/i3getgo

class=$($GET -c)
out=$($GET -O)
primary=$($GET -P)
title=$($GET -t)

# set bigger font for external output
[[ $out != $primary ]] && FONT="-f monospace:size=14" || FONT=

if [[ $class =~ "Emacs" ]]; then
    FILE=$(basename "$title")
    DIR=${title%$FILE}
    [[ -d $DIR ]] && cd $DIR
    st -c term -t "st @$(date +%H:%M:%S)" $FONT $EXEC &
else
    [[ $class == term ]] && DIR=$(echo $title | awk '{print $NF}') || DIR=$PWD
    cd $DIR
    st -c term -t "st @$(date +%H:%M:%S)" $FONT $EXEC &
fi
