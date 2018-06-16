#!/bin/bash

# Path:        ~/.dotfiles/bin/i3temp-warning.sh
# Created:     07.06.18, 18:11    @manjaroi3
# Last update: 16.06.18, 20:59:58 @lenovo

# DOC: Script used to inform about high core's temperature in i3blocks

# STATUS:
# todo: sprawdzić jak wygląda to na lenovo; czy da się to uspójnić?

# PER MACHINE VARIABLES:

# toshiba (manjaro)
temp=`sensors | grep Physical | awk '{print $4}' | grep -o [0-9]* | head -n 1`
high=`sensors | grep Physical | awk '{print $7}' | grep -o [0-9]* | head -n 1`
crit=`sensors | grep Physical | awk '{print $10}'| grep -o [0-9]* | head -n 1`
CRIT=$(( $crit - 5 ))

# x300
tempx=`sensors | grep Core | awk '{print $3}' | grep -o [0-9]* | head -n 1`
highx=85
critx=`sensors | grep Core | awk '{print $9}'| grep -o [0-9]* | head -n 1`
CRITX=$(( $critx - 5 ))

# CODE:

# set proper variables
if (( $HOSTNAME == "x200" )); then
    TEMP=$tempx
    CRITIC=$critx
    HIGH=$highx
else
    TEMP=$temp
    CRITIC=$crit
    HIGH=$high
fi

# return info

if (( $TEMP >= $CRITIC )); then
    echo -e "<span bgcolor=\"#E74C3C\"> $TEMP°C! </span>"
elif (( $TEMP >= $HIGH )); then
    echo -e "<span bgcolor=\"#adff2f\" fgcolor=\"#34495e\"> $TEMP°C </span>"
fi
    
# echo $TEMP
# echo $HIGH
# echo $CRITIC

