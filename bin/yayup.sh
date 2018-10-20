#!/bin/bash

# Path:        ~/scr/yayup.sh
# Created:     20.10.18, 12:39    @lenovo
# Last update: 20.10.18, 12:41:09 @lenovo

# >> DOC:
# just a helper script to reset i3blocks (it doesn't work when run from an alias...)

# >> RUN: 
yay -Syu && pkill -RTMIN+12 i3blocks
