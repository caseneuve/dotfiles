#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-sys-dispatcher.sh
# Created:     03.05.18, 14:11    @x200
# Last update: 11.05.18, 00:38:02 @lenovo

# Doc: List of system commands passed to rofi (shutdown, exit etc.)


list="[1] screen lock\n[2] sleep\n[3] reboot\n[4] power off\n[5] i3 - restart\n[6] i3 - reload"

echo -e $list

case $1 in
    '[2] sleep')
        systemctl suspend; pkill rofi ;;
    '[3] reboot')
        systemctl reboot -i ;;
    '[4] power off')
        systemctl poweroff -i ;;
    '[5] i3 - restart')
        i3-msg restart ;;
    '[6] i3 - reload')
        i3-msg reload ;;
    '[1] screen lock')
        i3-msg "exec --no-startup-id ~/.dotfiles/i3/i3lock/lock.sh"; pkill rofi ;;
    *) eval "$1" ;;
esac

