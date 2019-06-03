#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-cmd.sh
# Created:     2019-06-03, 10:05    @toshiba
# Last update: 2019-06-03, 10:48:31 @toshiba
# Doc:

cmd=$(echo "" | dmenu -fn "Iosevka:style=Bold:size=11")
OUTPUT=$(sh -c "$cmd" 2>/dev/null)

[[ -n $OUTPUT ]] \
    && notify-send "$cmd" "\n$OUTPUT" \
        || notify-send -u critical "$cmd" "is not a valid command"
