#!/bin/bash

# ~/.dotfiles/bin/kbd-help.sh
# Created:     01.01.18, 17:49    @manjaroi3
# Last update: 03.04.18, 19:04:03 @lenovo

# Doc: 

cd /home/piotr/.help

if [ -z "$2" ]; then
    less -FX $1
else
    cat $1 | grep $2
fi

