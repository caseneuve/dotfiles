#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/weather.sh
# Created:     14.05.18, 19:06    @x200
# Last update: 10.07.18, 22:33:46 @x200

# Doc: Script to show weather, temperature and rainfall for current location and time

# TODO: jak automatycznie sprawdzić lokację?

location=Falenica
icon=/home/piotr/.dotfiles/i3/bin/weather-icon.png

echo "<span weight='bold'>$(date '+%H:%M')</span> "

case $BLOCK_BUTTON in
    #    1) ~/.dotfiles/bin/notify-weather.sh ;;
    1) ~/.dotfiles/bin/notify-uedder-new.sh ;;
    3) if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ];
       then
           qutebrowser wttr.in/$location;
       else
           notify-send "METEO" "Check internet connection!" -i $icon;
       fi ;;
esac
exit 0

