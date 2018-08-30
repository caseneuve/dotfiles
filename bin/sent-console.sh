#!/bin/bash

# Path:        ~/.dotfiles/bin/sent-console.sh
# Created:     28.08.18, 19:37    @x200
# Last update: 30.08.18, 23:06:45 @lenovo

# >> DOC: 
# simple console to navigate through SENT slides
# 30/08/2018 v0.2 → read file, count slides
# note: input file must not have trailing newlines at the end

# >> TODOS:
# todo: add marks (goto marked slide)
# todo: add goto slide nr (,2 → goto 2; ,3 → goto 3 etc)
# done: when sent instance added/removed during run it has to "reload", otherwise it looses one round
# done: add counters, eg : 5n, 5p etc.
# done: read file, and echo which slide we are currently on 
# licz ile jest przerw między akapitami, tj ile slajdów
# cat -s $file | grep -c "^\s*$"

# >> VARIABLES:
MSG="Sent console v0.2 alpha"
# spr. czy podany arg jest plikiem 
# >> - file ops @v
if [[ -f $1 ]]; then
    TOTAL=$(cat $1 | grep -v "^#" | cat -s | grep -c "^\s*$")
    FILE=$(basename $1)
    COUNT=1
elif [[ $1 == '-h' ]]; then
    echo "usage: sent-console [sent file] [nr of instances]"
    exit
fi

# >> - how many instances @v
if [[ $2 =~ [0-9]+ ]]; then
    a=$2
    for ((n=0;n<$2;n++)); do
        sent $1 &
    done
fi

# >> RUN:
clear

echo "Sent console v0.2 alpha"

# >> loop start 
while true; do
    if [[ -f $1 ]]; then
        read -p "[ $FILE $COUNT/$TOTAL ] > " command
    else
        read -p "> " command
    fi
    
    [[ $(echo $command | grep [0-9]) ]] && num=$(echo $command | grep -o "[0-9]*") || num=1
    command=$(echo $command | grep -o "[a-z]*")

    SENT_ID=$(xdotool search --class sent)

    if [[ -z $SENT_ID ]]; then
        [[ $(echo "quit exit q" | grep $command) ]] && exit
        echo "no sent presentation active!"
    fi

    # >> command process @loop
    for i in $SENT_ID; do
        case $command in
            n|p) for ((n=0;n<$num;n++)); do
                     xdotool key --window $i $command 2> /dev/null
                     done ;;
            a|g|r) xdotool key --window $i $command 2> /dev/null ;;
            'exit'|'quit') exit ;;
            'kill') pkill sent && exit ;;
            clr|clear|klr) clear; echo $MSG ;;
            *) echo "commands are: <num>[n]ext, <num>[p]revious, [r]eload, [a] beg, [g] end"
               break ;;
        esac
    done

    # >> reloaded msg
    [[ $command == 'r' ]] && echo "slides reloaded!" 
    
    # >> set counter @loop
    if [[ $TOTAL ]]; then
        case $command in
            n) if (( COUNT + num <= TOTAL )); then
                   COUNT=$((COUNT+num))
               else
                   COUNT=$TOTAL
                   echo "no more slides!"
               fi ;;
            p) if (( COUNT - num > 0 )); then
                   COUNT=$((COUNT-num))
               else
                   COUNT=1
                   echo "you're already at the beginning!"
               fi ;;
            g) COUNT=$TOTAL ;;
            a) COUNT=1 ;;
            r) TOTAL=$(cat $1 | grep -v "^#" | cat -s | grep -c "^\s*$") ;;
        esac
    fi
done
        
