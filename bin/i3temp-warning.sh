#!/bin/bash

# Path:        ~/.dotfiles/bin/i3temp-warning.sh
# Created:     07.06.18, 18:11    @manjaroi3
# Last update: 20.01.19, 00:43:54 @lenovo

# DOC: Script used to inform about high core's temperature in i3blocks

# STATUS:
# todo: sprawdzić jak wygląda to na lenovo; czy da się to uspójnić?

# PER MACHINE VARIABLES:

# toshiba (manjaro)
temp=`sensors | grep Physical | awk '{print $4}' | grep -o [0-9]* | head -n 1`
high=`sensors | grep Physical | awk '{print $7}' | grep -o [0-9]* | head -n 1`
crit=`sensors | grep Physical | awk '{print $10}'| grep -o [0-9]* | head -n 1`
CRIT=$(( $crit - 5 ))

# x200
tempx=`sensors | grep Core | awk '{print $3}' | grep -o [0-9]* | head -n 1`
highx=85
critx=`sensors | grep Core | awk '{print $9}'| grep -o [0-9]* | head -n 1`
CRITX=$(( $critx - 5 ))

# lenovo
templ=`sensors | grep "Package id 0" | awk '{print $4}' | grep -o [0-9]* | head -n 1`
highl=84
critl=95

# CODE:

# set proper variables
if [ "$HOSTNAME" == "x200" ]; then
    TEMP=$tempx
    CRITIC=$critx
    HIGH=$highx
elif [ "$HOSTNAME" == "toshiba" ]; then
    TEMP=$temp
    CRITIC=$crit
    HIGH=$high
elif [ "$HOSTNAME" == "lenovo" ]; then
    TEMP=$templ
    CRITIC=$critl
    HIGH=$highl
fi

# return info

if (( $TEMP >= $CRITIC )); then
    # <span bgcolor='#00001f26'>
    echo -e "<span color='#C0392B'><span weight='bold'> $TEMP°C!</span></span>"
elif (( $TEMP >= $HIGH )); then
#    echo -e "<span bgcolor=\"#adff2f\" fgcolor=\"#34495e\"> $TEMP°C</span>"
    echo -e " $TEMP°C"
fi
    
# echo $TEMP
# echo $HIGH
# echo $CRITIC

