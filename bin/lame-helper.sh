#!/bin/bash

# Path:        ~/.dotfiles/bin/lame-helper.sh
# Created:     15.05.18, 15:40    @lenovo
# Last update: 15.05.18, 16:05:07 @lenovo

# Doc: Convert all .wav files in directory to .mp3 format
# note: files mustn't have spaces in names!

package=lame

if pacman -Qi $package &> /dev/null ; then
    for file in `find -type f -name '*.wav'`
    do
        file="$(basename $file)";
        lame $file
    done
else
    echo "Paczka $package nie jest zainstalowana"
fi

