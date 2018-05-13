#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/date.sh
# Created:     13.05.18, 18:16    @x200
# Last update: 13.05.18, 19:02:45 @x200

# Doc: script to display date in i3 blocks and send notifications via CALCURSE about coming calendar events

tod=$(date +%)
echo $(date '+%a, %d %b')

case $BLOCK_BUTTON in
    1) notify-send "Calendar $(date +%d/%m):" "$(calcurse -n | tail -n 1 | sed 's/   //g')" -i ~/.dotfiles/i3/bin/calendar-icon.png ;; # left click = previous song
    2) calcurse ;; # middle click
    3) notify-send "Calendar $(date --date=tomorrow +%d/%m):" "$(calcurse -s$(date --date=tomorrow +%m/%d/%Y) --format-recur-apt='%m (%S-%E)\n' --format-apt='%m (%S-%E)\n' | sed -n 2p)" -i ~/.dotfiles/i3/bin/calendar-icon.png ;; # right clic
esac
exit 0

