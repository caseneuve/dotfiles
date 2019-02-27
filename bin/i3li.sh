#!/bin/bash

# Path:        ~/.dotfiles/bin/i3li.sh
# Created:     2019-02-27, 10:41    @x200
# Last update: 2019-02-27, 10:45:35 @x200
# Doc:         Quickly restart i3listen.py script

ps aux | rg "python .*i3listen.py" | rg -v rg | awk '{print $2}' | xargs kill -9

~/git/hub/i3/i3listen.py &

