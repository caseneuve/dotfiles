#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/weather.sh
# Created:     14.05.18, 19:06    @x200
# Last update: 14.05.18, 19:24:17 @x200

# Doc: Script to show weather, temperature and rainfall for current location and time

# TODO: jak automatycznie sprawdzić lokację?

location=Falenica
icon=/home/piotr/.dotfiles/i3/bin/weather-icon.png

echo $(date '+%H:%M')

case $BLOCK_BUTTON in
    1) if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ];
       then
           curl wttr.in/$location > ~/.weatherreport && notify-send "METEO @$location" "$(cat .weatherreport | sed '3q;d' | sed 's/.*0m //') \
☀️ $(cat .weatherreport | sed '4q;d' | grep -o 'm[-0-9 ]*' | grep -o '[0-9]*')°C \
☂ $(cat .weatherreport | sed '7q;d' | grep -o '0m.* mm' | sed 's/0m //')" -i $icon;
       else
           notify-send "METEO" "Check internet connection!" -i $icon;
       fi ;;
    3) if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ];
       then
           qutebrowser wttr.in/$location;
       else
           notify-send "METEO" "Check internet connection!" -i $icon;
       fi ;;
esac
exit 0

