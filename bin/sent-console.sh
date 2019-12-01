#!/bin/bash

# Path:        ~/.dotfiles/bin/sent-console.sh
# Created:     28.08.18, 19:37    @x200
# Last update: 2019-12-01, 21:48:01 @lenovo

# >> DOC: simple console to navigate through SENT slides
# 12/09/2018 v0.3 → cosmetics (colors, args, <return> = new slide)
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
MSG="Sent console v0.3 alpha"
# >> COLORS @var
bd=$(tput bold)
res=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)
blu=$(tput setaf 4)
whibg=$(tput setab 15)
blafg=$(tput setaf 0)
redbg=$(tput setab 1)

# spr. czy podany arg jest plikiem 
# >> - file ops @v
if [[ -f $1 ]]; then
    TOTAL=$(grep -v "^#" $1 | cat -s | grep -c "^\s*$")
    FILE=$(basename $1)
    COUNT=1
elif [[ $1 == '-h' || -z $1 ]]; then
    echo "usage: sent-console [sent file] [nr of instances]"
    exit
fi

# >> - how many instances @v
if [[ $2 =~ [0-9]+ ]]; then
    a=$2
else
    a=2
fi

for ((n=0;n<$a;n++)); do
    sent $1 &
done


# >> RUN:
clear

echo $MSG

# >> loop start 
while true; do
    # >> prepre
    [[ -n $NOTE ]] && NOOT=", #$(echo -e $NOTE | wc -l)" || NOOT=
    [[ -n $POS ]] && POOS="+$POS" || POOS=
    # >> pre prompt @loop
    if [[ -n $MARK ]]; then
        REST=", *$MARK$POOS"
    else
        REST=
    fi

    # >> read @loop
    if [[ -f $1 ]]; then
        read -p "[ $FILE $COUNT/$TOTAL$REST$NOOT ] > " command
    else
        read -p "[ $COUNT/$TOTAL$REST$NOOT ] > " command
    fi

    if [[ $command != *"# "* ]]; then
        [[ $(echo $command | grep [0-9]) ]] && num=$(echo $command | grep -o "[0-9]*") || num=1
        command=$(echo $command | grep -o "[a-z]*")
    fi

    # >> jump to the marked @loop
    if [[ $command == "j" ]]; then
        [[ -z $MARK ]] && echo "${red}no slide marked!${res}" && continue
        POS=$COUNT
        DIFF=$(( COUNT - MARK ))
        num=$(echo $DIFF | grep -o "[0-9]*")
        (( DIFF > 0 )) && command="p" || command="n"
        echo "${yel}jumping to the marked slide $MARK!${res}"
    fi

    # >> and go back
    if [[ $command == "t" ]]; then
        [[ -z $POS ]] && echo "${red}no saved position to go back!${res}" && continue
        if [[ $POS == $COUNT ]]; then
            echo "${red}no need to jump back...${res}"
            continue
        fi
        DIFF=$(( POS - COUNT ))
        num=$(echo $DIFF | grep -o "[0-9]*")
        (( DIFF < 0 )) && command="p" || command="n"
        echo "${yel}...and jumping back to the slide $POS!${res}"
        POS=$COUNT
    fi
        
    SENT_ID=$(xdotool search --class sent)

    if [[ -z $SENT_ID ]]; then
        [[ $(echo "quit exit q" | grep $command) ]] && exit
        echo "${red}no sent presentation active!${res}"
    fi

    # >> command process @loop
    for i in $SENT_ID; do
        case $command in
            '') xdotool key --window $i n 2> /dev/null ;;
            n|p) for ((n=0;n<$num;n++)); do
                     xdotool key --window $i $command 2> /dev/null
                     done ;;
            a|g|r) xdotool key --window $i $command 2> /dev/null ;;
            'exit'|'quit') exit ;;
            'kill') pkill sent && exit ;;
            clr|clear|klr) clear; echo $MSG ;;
            m) MARK=$COUNT; echo "${yel}slide $MARK marked!${res}"; break ;;
            c) MARK=; POS=; echo "${yel}marks cleared!${res}"; break ;;
            '# '*) [[ -n $NOTE ]] && NOTE="$NOTE\n$command (@$COUNT)" || NOTE="$command (@$COUNT)"
                   break ;;
            f) [[ $NOTE ]] && echo -e "${gre}$NOTE${res}" || echo "${red}no notes!${res}"
               break ;;
            x) NOTE=; echo "${gre}notes cleared!${res}"; break ;;
            *) echo -e "commands are:
 <num>[n]ext,
 <num>[p]revious,
 [r]eload,
 [a] beg,
 [g] end,
 [m]ark slide,
 [j]ump to slide,
 [t]oggle jump pos.,
 [c]lear marks,
 [#] enter note,
 [f] print notes,
 [x] clear notes."
               break ;;
        esac
    done

    # >> reloaded msg
    [[ $command == 'r' ]] && echo "slides reloaded!" 
    
    # >> set counter @loop
    if [[ $TOTAL ]]; then
        case $command in
            n|'') if (( COUNT + num <= TOTAL )); then
                   COUNT=$((COUNT+num))
               else
                   COUNT=$TOTAL
                   echo "${red}no more slides!${res}"
               fi ;;
            p) if (( COUNT - num > 0 )); then
                   COUNT=$((COUNT-num))
               else
                   COUNT=1
                   echo "${red}you're already at the beginning!${res}"
               fi ;;
            g) COUNT=$TOTAL ;;
            a) COUNT=1 ;;
            r) TOTAL=$(grep -v "^#" $1 | cat -s | grep -c "^\s*$") ;;
        esac
    fi
done
        
