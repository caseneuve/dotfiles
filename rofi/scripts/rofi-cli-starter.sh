#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-cli-starter.sh
# Created:     29.04.18, 16:42    @x200
# Last update: 23.07.18, 00:16:47 @lenovo

# Doc:
# todo: rozbić na małe skrypty (np. uedder)

list="emacs @1\nqutebrowser @2\nterminal @3\nranger @6\nqutebrowser-private @7\nnewsboat (rss) @10\nneomutt (mail) @10\nmocp @8\ncalcurse (kal)\nranger @point\ncalendar next\ncalendar tomorrow\ncalendar today\nuedder\nsys-update info\nsys-update run"

#x=$(echo -e $list | rofi -dmenu -p "START CLI APP")
echo -e $list

case $1 in
    'emacs @1'|emm)
        i3-msg -q "workspace 1; exec --no-startup-id emacs" >/dev/null && pkill rofi ;;
    'qutebrowser @2'|'qb'|'qq')
        i3-msg -q "workspace 2; exec --no-startup-id qutebrowser" >/dev/null && pkill rofi ;;
    'ranger @6')
        i3-msg -q "workspace 6; exec --no-startup-id st -e ranger" && pkill rofi ;;
    'qutebrowser-private @7'|'qp')
        i3-msg -q "workspace 7; exec --no-startup-id qutebrowser :command \":open -p\"" >/dev/null && pkill rofi ;;
    'mocp @8'|mocp)
        i3-msg -q "workspace 8; exec --no-startup-id st -e mocp"; pkill rofi ;;
    'terminal @3')
        i3-msg -q "workspace 3; exec --no-startup-id st -t main" && pkill rofi ;;
    'newsboat (rss) @10')
        i3-msg -q "workspace 10; exec --no-startup-id st -e newsboat" >/dev/null && pkill rofi ;;
    'neomutt (mail) @10'|mmm)
        i3-msg -q "workspace 10; exec --no-startup-id st -e neomutt" && pkill rofi ;;
    'calcurse (kal)')
        i3-msg -q "exec --no-startup-id st -e calcurse"; pkill rofi ;;
    'ranger @point')
        i3-msg -q "exec --no-startup-id st -e ranger"; pkill rofi ;;
    'calendar next')
        if [ "$(calcurse -n)" ]; then
            notify-send "Calendar $(date +%d/%m):" "$(calcurse -n | tail -n 1 | sed 's/   //g')" -i ~/.dotfiles/i3/bin/calendar-icon.png;
        else
            notify-send "No events today" -i ~/.dotfiles/i3/bin/calendar-icon.png;
        fi; pkill rofi ;;
    'calendar tomorrow')
        if [ "$(calcurse -s$(date --date=tomorrow +%m/%d/%Y))" ]; then
            notify-send "Calendar $(date --date=tomorrow +%d/%m):" "$(calcurse -s$(date --date=tomorrow +%m/%d/%Y) --format-recur-apt='* %m (%S-%E)\n' --format-apt='* %m (%S-%E)\n' | tail -n +2)" -i ~/.dotfiles/i3/bin/calendar-icon.png;
        else
            notify-send "No events tomorrow" -i ~/.dotfiles/i3/bin/calendar-icon.png;
        fi; pkill rofi ;;
    'calendar today')
        if [ "$(calcurse -a)" ]; then
            notify-send "Calendar $(date --date=today +%d/%m)" "$(calcurse -a --format-recur-apt='* %m (%S-%E)\n' --format-apt='* %m (%S-%E)\n\t→ %N' | tail -n +2 | grep -v 'No note')" -i ~/.dotfiles/i3/bin/calendar-icon.png;
        else
            notify-send "No events tomorrow" -i ~/.dotfiles/i3/bin/calendar-icon.png;
        fi; pkill rofi ;;
    'uedder')
        #~/.dotfiles/bin/notify-weather.sh; pkill rofi ;;
        ~/.dotfiles/bin/notify-uedder-new.sh; pkill rofi ;;
    'sys-update info') if [[ "$(checkupdates)" ]]; then
                           notify-send -u critical "System update:
==============" "$(checkupdates)" && pkill -RTMIN+12 i3blocks; pkill rofi;
                       else
                           notify-send -u low "System update:
==============" "System is up to date" && pkill -RTMIN+12; pkill rofi;
                       fi;;
    'sys-update run') if [[ "$(checkupdates)" ]]; then
                          i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu && pkill -RTMIN+12 i3blocks" && pkill rofi;
                          exit 0
                      else
                          notify-send -u low "System update:
==============" "System is up to date" && pkill -RTMIN+12; pkill rofi;
                       fi;;
    *) eval "$1" ;;
esac

