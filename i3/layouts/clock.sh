#!/bin/bash

# Path:        ~/scr/clock.sh
# Created:     18.07.18, 20:47    @x200
# Last update: 19.07.18, 01:01:49 @x200

# Doc:
# note: depency → figlet
# idea:         https://bbs.archlinux.org/viewtopic.php?id=68663
# figlet fonts: http://www.flamingtext.com/tools/figlet/fontlist.html

FONT=block

BLACK=0
RED=1
GREEN=2
ORANGE=3
BLUE=4
MAGENTA=5
CYAN=6
GREY=7

COLOR=$GREEN
COLOR2=$BLACK
COLOR3=$COLOR
HOUR=$RED

choose_color(){
    MIN=`date +"%M"`
    if [[ $(echo $MIN | grep -o "00\|15\|30") ]]; then
        echo $(tput setaf $HOUR)
    else
        echo $(tput setaf $COLOR)
    fi
}

current_task(){
    TASK=`emacsclient -e '(message (format "%s" org-clock-current-task))' | xargs`
    TIME=`emacsclient -e '(message (format "%s" (substring-no-properties
(org-clock-get-clock-string))))' | xargs`
    TIME=${TIME%(*}
    [[ $TASK != "nil" ]] && echo "clocking: $TASK$TIME"
}

while true; do
    tput clear;
    tput bold
    choose_color
    echo -e "\n\n"
    date +"%H : %M" | figlet -f $FONT -c;
    tput setaf $COLOR2;    
    echo "-------------------------------------------------------------------------"
    tput sgr0
    tput setaf $COLOR3;
    echo `date +"%d, %B %Y"`
    current_task
    echo `calcurse -n`
    tput civis #invisible cursor; "tput cnorm" --> normal
    sleep 30;
done
