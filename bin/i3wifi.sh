#!/bin/bash

# Path:        ~/.bin/i3wifi.sh
# Created:     10.07.18, 14:37    @x200
# Last update: 12.07.18, 20:44:43 @toshiba

# Doc:

IF=$(ip route | awk '/^default/ { print $5 ; exit }')

CONN=`ping -c 1 1.1.1.1 2>/dev/null`
QUALITY=$(grep $IF /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

# if [[ "$(cat /sys/class/net/$IF/operstate)" = 'down' ]]; then
#   echo down # full text
#   echo down # short text
#   echo \#FF0000 # color
#   exit
# fi

if [[ "$(cat /sys/class/net/$IF/operstate)" = 'down' ]]; then
#if [[ ! $(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`) ]]; then
    echo "<span fgcolor=\"#e74c3c\">▼ down</span>"
    exit
fi

if [[ `echo $CONN | grep Unreachable` ]]; then
    echo "<span fgcolor='#c0392b'><span bgcolor='#ececec'> ▼ ✕ </span></span>"
else
    echo "▼ $QUALITY%"
fi

#if [ ! `echo $CONN` = "" ]; then echo "zero"; fi
# ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo ok || echo error
