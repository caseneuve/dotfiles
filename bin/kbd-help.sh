# ~/.dotfiles/bin/kbd-help.sh
# Created:     01.01.18, 17:49    @manjaroi3
# Last update: 01.01.18, 17:59:50 @manjaroi3

# Doc: 

#!/bin/bash

cd /home/piotr/.help

if [ -z "$2" ]; then
    less -FX $1
else
    cat $1 | grep $2
fi
