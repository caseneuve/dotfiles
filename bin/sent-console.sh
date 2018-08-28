#!/bin/bash

# Path:        ~/.dotfiles/bin/sent-console.sh
# Created:     28.08.18, 19:37    @x200
# Last update: 29.08.18, 01:10:37 @x200

# >> DOC: 
# simple console to navigate through SENT slides

# >> TODOS: 
# todo: add counters, eg : 5n, 5p etc.
# todo: read file, and echo which slide we are currently on 

# >> RUN:
clear
echo "Sent console v0.1 alpha"

while true; do
    SENT_ID=$(xdotool search --class sent)
    read -p "> " command
    for i in $SENT_ID; do
        case $command in
            a|g|n|p|r) xdotool key --window $i $command
                       ;;
            'exit'|'quit') exit
                       ;;
            clr|clear|klr) clear; echo "Sent console v0.1 alpha"
                           ;;
            *) echo "commands are [n]ext, [p]revious, [r]eload, [a]beg [g]end"
               break
               ;;
        esac
    done
done
        
