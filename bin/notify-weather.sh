#!/bin/bash

# Path:        ~/.dotfiles/bin/notify-weather.sh
# Created:     15.05.18, 13:26    @x200
# Last update: 17.05.18, 11:57:29 @manjaroi3

# Doc: Send notification about wather via wttr.in web site

location=Warsaw
icon=/home/piotr/.dotfiles/i3/bin/weather-icon.png

if [ "$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3`)" ]; then curl wttr.in/$location > /home/piotr/.weatherreport && notify-send "METEO @$location" "$(cat ~/.weatherreport | sed '3q;d' | sed 's/.*0m //' | sed 's/[ \t]*//') ☀️ $(cat ~/.weatherreport | sed '4q;d' | grep -o 'm[0-9]*' | grep -o '[0-9]*' | tr '\n' '-' | sed -r 's/(.*)-/\1/')°C ☂ $(cat ~/.weatherreport | sed '7q;d' | grep -o '[0-9\.]* mm' | sed 's/0m //')" -i $icon; else notify-send "METEO" "Check internet connection!" -i $icon; fi

