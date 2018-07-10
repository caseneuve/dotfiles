#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/i3win-title.sh
# Created:     10.07.18, 21:21    @x200
# Last update: 11.07.18, 00:07:01 @lenovo

# Doc:

name=`xdotool getactivewindow getwindowname`
len=`echo ${#name}`
max=40

if (( $len > 0 )); then
    if (( $len > $max )); then
        let a=$len-$max
        echo "<span bgcolor='#00001f26'> ${name::-$a}… </span>"
    else
        echo "<span bgcolor='#00001f26'> $name </span>"
    fi
else
    echo 
fi

