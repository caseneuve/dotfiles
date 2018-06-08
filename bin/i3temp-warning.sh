#!/bin/bash

# Path:        ~/.dotfiles/bin/i3temp-warning.sh
# Created:     07.06.18, 18:11    @manjaroi3
# Last update: 08.06.18, 02:20:09 @manjaroi3

# Doc: Script used to inform about high core's temperature in i3blocks

temp=`sensors | grep Physical | awk '{print $4}' | grep -o [0-9]* | head -n 1`
high=`sensors | grep Physical | awk '{print $7}' | grep -o [0-9]* | head -n 1`
crit=`sensors | grep Physical | awk '{print $10}'| grep -o [0-9]* | head -n 1`
CRIT=$(( $crit - 5 ))

if (( $temp >= $CRIT )); then
    echo -e "<span bgcolor=\"#E74C3C\"> $temp°C! </span>"
elif (( $temp >= $high )); then
    echo -e "<span bgcolor=\"#adff2f\" fgcolor=\"#34495e\"> $temp°C </span>"
fi

