#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/date.sh
# Created:     13.05.18, 18:16    @x200
# Last update: 13.05.18, 19:34:08 @x200

# Doc: script to display date in i3 blocks and send notifications via CALCURSE about coming calendar events
# TODO: scroll up/down (events yesterday, today all)

tod=$(date +%)
echo $(date '+%a, %d %b')

case $BLOCK_BUTTON in
    # left click = previous song
    1) if [ "$(calcurse -n)" ];
       then
           notify-send "Calendar $(date +%d/%m):" "$(calcurse -n | tail -n 1 | sed 's/   //g')" -i ~/.dotfiles/i3/bin/calendar-icon.png;
       else
           notify-send "No events today" -i ~/.dotfiles/i3/bin/calendar-icon.png;
       fi ;;
    # middle click
    2) calcurse ;;
    # right click
    3) if [ "$(calcurse -s$(date --date=tomorrow +%m/%d/%Y))" ];
       then
           notify-send "Calendar $(date --date=tomorrow +%d/%m):" "$(calcurse -s$(date --date=tomorrow +%m/%d/%Y) --format-recur-apt='* %m (%S-%E)\n' --format-apt='* %m (%S-%E)\n' | tail -n +2)" -i ~/.dotfiles/i3/bin/calendar-icon.png;
       else
           notify-send "No events tomorrow" -i ~/.dotfiles/i3/bin/calendar-icon.png;
       fi ;; 
esac
exit 0

