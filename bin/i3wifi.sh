#!/bin/bash

# Path:        ~/.bin/i3wifi.sh
# Created:     10.07.18, 14:37    @x200
# Last update: 13.07.18, 01:23:06 @lenovo

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

case $BLOCK_BUTTON in
    # left click 
    1) notify-send -u low "Dropbox status:
--------------" "$(dropbox-cli status)" -i ~/box/Dropbox/.Config/dropbox-logo.png && exit 0;;
esac
