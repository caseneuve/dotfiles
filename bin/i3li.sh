#!/bin/bash

# Path:        ~/.dotfiles/bin/i3li.sh
# Created:     2019-02-27, 10:41    @x200
# Last update: 2019-02-27, 11:22:26 @x200
# Doc:         Quickly restart i3listen.py script

SCRIPT_TIME=$(date +%H:%M)
SCRIPT_TIME_EPOCH=$(date -d "${SCRIPT_TIME}" +%s)

ps aux | rg "python .*i3listen.py" | rg -v rg | awk '{print $2}' \
    | xargs kill -9

~/git/hub/i3/i3listen.py &

RUN_TIME=$(ps aux | rg "python .*i3listen.py" | rg -v rg \
               | awk '{print $9}')
RUN_TIME_EPOCH=$(date -d "${RUN_TIME}" +%s)

if (($SCRIPT_TIME_EPOCH <= $RUN_TIME_EPOCH)); then
    notify-send "scripts" "i3listen.py reloaded"
else
    notify-send -u critical "scripts" "i3listen.py failed to reload"
fi


