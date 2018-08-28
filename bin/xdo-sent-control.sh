#!/bin/bash

# Path:        ~/.dotfiles/bin/xdo-sent-control.sh
# Created:     28.08.18, 12:40    @x200
# Last update: 28.08.18, 23:51:31 @x200

# >> DOC:
# Dep: xdotool
# Enables remote control on slides in @sent app

# >> TODOS: 

# >> VARIABLES: 
SENT_ID=$(xdotool search --class sent)


while getopts 'agnprq' flag; do
    if [[ -n $SENT_ID ]]; then
        for i in $SENT_ID; do
            case "${flag}" in
                a|g|n|p|r|q) xdotool key --window $i $flag 2>/dev/null
                             ;;
                *) xdotool key --window $i n
                   ;;
            esac
        done
    fi
done

# if [[ -n $SENT_ID ]]; then
#     for i in $SENT_ID; do
#         while getopts 'agnprq' flag; do
#             case "${flag}" in
#                 a|g|n|p|r|q) xdotool key --window $i $flag 2>/dev/null
#                              ;;
#                 *) xdotool key --window $i n
#                    ;;
#             esac
#         done
#     done
# fi
