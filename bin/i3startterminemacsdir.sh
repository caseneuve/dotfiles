#!/bin/bash

#* Path:        ~/.dotfiles/bin/i3startterminemacsdir.sh
#  Created:     26.08.18, 15:00    @x200
#  Last update: 2019-07-29, 14:00:05 @x200
#  Doc:         If an Emacs window is focused with a file in active buffer,
#               open the terminal in the working directory; 
#               else, open in $HOME.
#* Requires:    i3getgo
#* Code:

while getopts ":e:f:s:" option; do
    case "${option}" in
        e) EXEC="-e ${OPTARG}";;
        f) FONT="-f ${OPTARG}";;
        s) FONT="-f monospace:size=${OPTARG}";;
    esac
done

[[ -z $GOBIN ]] && GOBIN=$HOME/go/bin
GET=$GOBIN/i3getgo

class=$($GET -c)
out=$($GET -O)
primary=$($GET -P)
title=$($GET -t)

if [[ $class =~ "Emacs" ]]; then
    FILE=$(basename "$title")
    DIR=${title%$FILE}
    [[ -d $DIR ]] && cd $DIR
    st -c term -t "st @$(date +%H:%M:%S)" $FONT $EXEC &
else
    [[ $class == term ]] && DIR=$(echo $title | awk '{print $2}') || DIR=$PWD
    cd $DIR
    st -c term -t "st @$(date +%H:%M:%S)" $FONT $EXEC &
fi
