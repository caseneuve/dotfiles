#!/bin/bash

# Path:        ~/.dotfiles/bin/notify-uedder-new.sh
# Created:     17.05.18, 09:49    @manjaroi3
# Doc:         Send notification about current weather according to day time via wttr.in web site
# Todos:
# FIXME: how to nest variable in a command? (to avoid copying many times the same code...)
# e.g. in this command __ awk '/two/{i++}i==n' __  to expand n
# BUG: godziny z zerem wywalają błąd, np 08 >= 5
# done: with sed ↓

h=$(echo $(date +%H) | sed 's/^0//')
#location=Warszawa
location=Falenica
icon=/home/piotr/.dotfiles/i3/bin/weather-icon.png
WEATHERFILE=/home/piotr/.uedder

# send notify
if (( 5 <= $h )) && (( $h <= 9 )); then
    #morning
    if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ]; then
        curl wttr.in/$location > $WEATHERFILE && notify-send "METEO @$location -- $(sed '10q;d' $WEATHERFILE | grep -o '[A-Za-z]*' | awk '/[A-Za-z]*/{i++}i==1' | tr '[:upper:]' '[:lower:]'):" "$(sed '12q;d' $WEATHERFILE | grep -Eo '[^m ]* [A-Za-z ]*' | grep '[A-Z]' | awk '{print $1 " " $2}' | awk '/[a-z]/{i++}i==1')  ☀ $(sed '13q;d' $WEATHERFILE | grep -o 'm[0-9]*' | grep -o '[0-9]*' | awk '/[0-9]*/{i++}i==1')°C  ☂ $(sed '16q;d' $WEATHERFILE | grep -o '[0-9\.]* mm . [0-9]*%' | awk '/[0-9\.]* mm/{i++}i==1')" -i $icon
    else
        notify-send "METEO" "Check internet connection!" -i $icon;
    fi

    #noon
elif (( 10 <= $h )) && (( $h <= 14 )); then
    if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ]; then
        curl wttr.in/$location > $WEATHERFILE && notify-send "METEO @$location -- $(sed '10q;d' $WEATHERFILE | grep -o '[A-Za-z]*' | awk '/[A-Za-z]*/{i++}i==2' | tr '[:upper:]' '[:lower:]'):" "$(sed '12q;d' $WEATHERFILE | grep -Eo '[^m ]* [A-Za-z ]*' | grep '[A-Z]' | awk '{print $1 " " $2}' | awk '/[a-z]/{i++}i==2')  ☀ $(sed '13q;d' $WEATHERFILE | grep -o 'm[0-9]*' | grep -o '[0-9]*' | awk '/[0-9]*/{i++}i==2')°C  ☂ $(sed '16q;d' $WEATHERFILE | grep -o '[0-9\.]* mm . [0-9]*%' | awk '/[0-9\.]* mm/{i++}i==2')" -i $icon
    else
        notify-send "METEO" "Check internet connection!" -i $icon;
    fi

elif (( 15 <= $h )) && (( $h <= 20 )); then
    #evening
    eval n=3
    if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ]; then
        curl wttr.in/$location > $WEATHERFILE && notify-send "METEO @$location -- $(cat $WEATHERFILE | sed '10q;d' | grep -o '[A-Za-z]*' | awk '/[A-Za-z]*/{i++}i==3' | tr '[:upper:]' '[:lower:]'):" "$(cat $WEATHERFILE | sed '12q;d' | grep -Eo '[^m ]* [A-Za-z ]*' | grep '[A-Z]' | awk '{print $1 " " $2}' | awk '/[a-z]/{i++}i==3')  ☀ $(cat $WEATHERFILE | sed '13q;d' | grep -o 'm[0-9]*' | grep -o '[0-9]*' | awk '/[0-9]*/{i++}i==3')°C  ☂ $(cat $WEATHERFILE | sed '16q;d' | grep -o '[0-9\.]* mm . [0-9]*%' | awk '/[0-9\.]* mm/{i++}i==3')" -i $icon
    else
        notify-send "METEO" "Check internet connection!" -i $icon;
    fi

    #night
elif (( $h <= 4 )) || (( $h >= 21 )) ; then
    if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ]; then
        curl wttr.in/$location > $WEATHERFILE && notify-send "METEO @$location -- $(cat $WEATHERFILE | sed '10q;d' | grep -o '[A-Za-z]*' | awk '/[A-Za-z]*/{i++}i==4' | tr '[:upper:]' '[:lower:]'):" "$(cat $WEATHERFILE | sed '12q;d' | grep -Eo '[^m ]* [A-Za-z ]*' | grep '[A-Z]' | awk '{print $1 " " $2}' | awk '/[a-z]/{i++}i==4')  ☀ $(cat $WEATHERFILE | sed '13q;d' | grep -o 'm[0-9]*' | grep -o '[0-9]*' | awk '/[0-9]*/{i++}i==4')°C  ☂ $(cat $WEATHERFILE | sed '16q;d' | grep -o '[0-9\.]* mm . [0-9]*%' | awk '/[0-9\.]* mm/{i++}i==4')" -i $icon
    else
        notify-send "METEO" "Check internet connection!" -i $icon;
    fi
fi

# # get phase of day 
    # "$(cat $WEATHERFILE | sed '10q;d' | grep -o '[A-Za-z]*' | awk '/[A-Za-z]*/{i++}i==$n')"
    # # get description
    # cat $WEATHERFILE | sed '12q;d' | grep -Eo '[^m ]* [A-Za-z ]*' | grep '[A-Z]' | awk '{print $1 " " $2}' | awk '/[a-z]/{i++}i==$n'
    # # get temperature
    # cat $WEATHERFILE | sed '13q;d' | grep -o 'm[0-9]*' | grep -o '[0-9]*' | awk '/[0-9]*/{i++}i==$n'
    # # get rainfall
    # cat $WEATHERFILE | sed '16q;d' | grep -o '[0-9\.]* mm . [0-9]*%' | awk '/[0-9\.]* mm/{i++}i==$n'
