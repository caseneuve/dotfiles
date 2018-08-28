#!/bin/bash

# Path:        ~/.dotfiles/bin/xdo-sent-control.sh
# Created:     28.08.18, 12:40    @x200
# Last update: 28.08.18, 14:15:38 @x200

# >> DOC:
# Dep: xdotool
# Enables remote control on slides in @sent app

# >> TODOS: 

# >> VARIABLES: 
SENT_ID=$(xdotool search --class sent)

if [[ -n $SENT_ID ]]; then
   while getopts 'agnprq' flag; do
       case "${flag}" in
           a|g|n|p|r|q) xdotool key --window $SENT_ID $flag 2>/dev/null
                  ;;
           *) xdotool key --window $SENT_ID n
              ;;
       esac
   done
fi
