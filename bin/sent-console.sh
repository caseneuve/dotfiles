#!/bin/bash

# Path:        ~/.dotfiles/bin/sent-console.sh
# Created:     28.08.18, 19:37    @x200
# Last update: 31.08.18, 00:32:03 @lenovo

# >> DOC: simple console to navigate through SENT slides
# 30/08/2018 v0.2 → read file, count slides, mark/jump  
# note: input file must not have trailing newlines at the end

# >> TODOS:
# todo: add goto slide nr (,2 → goto 2; ,3 → goto 3 etc)
# todo: add colors (?)
# done: add marks (goto marked slide)
# done: when sent instance added/removed during run it has to "reload", otherwise it looses one round
# done: add counters, eg : 5n, 5p etc.
# done: read file, and echo which slide we are currently on 

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
    # >> prepre
    [[ -n $POS ]] && POOS="+$POS" || POOS=
    # >> pre prompt @loop
    if [[ -n $MARK ]]; then
        REST=", *$MARK$POOS"
    else
        REST=
    fi

    # >> read @loop
    if [[ -f $1 ]]; then
        read -p "[ $FILE $COUNT/$TOTAL$REST ] > " command
    else
        read -p "[ $COUNT/$TOTAL$REST ] > " command
    fi
    
    [[ $(echo $command | grep [0-9]) ]] && num=$(echo $command | grep -o "[0-9]*") || num=1
    command=$(echo $command | grep -o "[a-z]*")

    # >> jump to the  marked @loop
    if [[ $command == "j" ]]; then
        [[ -z $MARK ]] && echo "no slide marked!" && continue
        POS=$COUNT
        DIFF=$(( COUNT - MARK ))
        num=$(echo $DIFF | grep -o "[0-9]*")
        (( DIFF > 0 )) && command="p" || command="n"
        echo "jumping to the marked slide $MARK!"
    fi

    # >> and go back
    if [[ $command == "b" ]]; then
        [[ -z $POS ]] && echo "no saved position to go back!" && continue
        if [[ $POS == $COUNT ]]; then
            echo "no need to jump back..."
            continue
        fi
        DIFF=$(( POS - COUNT ))
        num=$(echo $DIFF | grep -o "[0-9]*")
        (( DIFF < 0 )) && command="p" || command="n"
        echo "and jumping back to the slide $POS!"
        POS=$COUNT
    fi
        
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
            m) MARK=$COUNT
               echo "slide $MARK marked!"
               break ;;
            c) MARK=
               POS=
               echo "marks cleared!"
               break ;;
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
        
