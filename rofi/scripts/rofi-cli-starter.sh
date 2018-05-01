#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-cli-starter.sh
# Created:     29.04.18, 16:42    @x200
# Last update: 01.05.18, 11:41:19 @x200

# Doc:

list="emacs @1\nqutebrowser @2\nterminal @3\nranger @6\nqutebrowser-private @7\nnewsboat (rss) @10\nneomutt (mail) @10\nmocp @8\ncalcurse (kal)"

#x=$(echo -e $list | rofi -dmenu -p "START CLI APP")
echo -e $list

case $1 in
    'newsboat (rss) @10')
        i3-msg "workspace 10; exec --no-startup-id st -e newsboat" >/dev/null && pkill rofi ;;
    'neomutt (mail) @10'|mmm)
        i3-msg "workspace 10; exec --no-startup-id st -e neomutt" && pkill rofi ;;
    'ranger @6')
        i3-msg "workspace 6; exec --no-startup-id st -e ranger" && pkill rofi ;;
    'mocp @8'|mocp)
        i3-msg "workspace 8; exec --no-startup-id st -e mocp"; pkill rofi ;;
    'calcurse (kal)')
        i3-msg "exec --no-startup-id st -e calcurse"; pkill rofi ;;
    qutebrowser-private)
        i3-msg -q "workspace 7; exec --no-startup-id qutebrowser :command \":open -p\"" >/dev/null && pkill rofi ;;
    'qutebrowser @2'|'qb'|'qq')
        i3-msg -q "workspace 2; exec --no-startup-id qutebrowser" >/dev/null && pkill rofi ;;
    'emacs @1'|emm)
        i3-msg "workspace 1; exec --no-startup-id emacs" >/dev/null && pkill rofi ;;
    'terminal @3')
        i3-msg "workspace 3; exec --no-startup-id st -t main" && pkill rofi ;;
    *) ;;
esac

