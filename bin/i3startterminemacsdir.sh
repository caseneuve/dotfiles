#!/bin/bash

#* Path:        ~/.dotfiles/bin/i3startterminemacsdir.sh
#  Created:     2018-08-26, 15:00    @x200
#  Last update: 2019-10-29, 09:01:41 @lenovo
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
else
    if [ $class = term ]; then
        IFS=' ' read -r -a parts <<< "$title"
        if [[ -n $(grep "(.*)" <<< "${parts[0]}") ]]; then
            VENV=$(sed 's/(\|)//g' <<< "${parts[0]}")
            DIR="${parts[2]}"
        else
            DIR="${parts[1]}"
        fi
    else
        DIR="$PWD"
    fi
    
    [[ -n "$VENV" ]] && source ~/.virtualenvs/$VENV/bin/activate
    
fi

[[ -d $DIR ]] && cd $DIR
st -c term -t "st @$(date +%H:%M:%S)" $FONT $EXEC &
