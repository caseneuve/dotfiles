#!/bin/bash

# Path:        ~/.dotfiles/bin/taffy-multifile.sh
# Created:     15.05.18, 16:08    @lenovo
# Last update: 23.05.18, 13:37:35 @x200

# Doc:
# BUG: źle czyta nazwy plików w rangerze... (rozbija je na części, jeśli są spacje)

package=taffy
n=1
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)

clear

echo "${yel}${bold}### Executing _taffy-multifile_ script ${normal}"
echo "##  Value 'nil' clears the tag, empty value does nothing"
echo
echo "working directory: ${bold}${gre}$PWD${normal}"
read -p "${bold}${red} →  What is the ${yel}ARTIST ${red}name?${normal}
 ....... " artist
read -p "${bold}${red} →  What is the ${yel}ALBUM ${red}name?${normal}
 ....... " album
read -p "${bold}${red} →  Specify ${yel}GENRE${red}:${normal}
 ....... " genre
read -p "${bold}${red} →  Do you want to ${yel}add${red} track numbers? (Y/nil)${normal}
 ....... " number
if pacman -Qi $package &> /dev/null ; then
    for file in `ls *.mp3`
    do
        file="$(basename $file)";
        if ! [ -z "$album" ]; then
            if [ "$album" == "nil" ]; then
                taffy --no-album $file
            else
                taffy -l "$album" $file
            fi
        fi;
        if ! [ -z "$artist" ]; then
            if [ "$artist" == "nil" ]; then
                taffy --no-artist $file
            else
                taffy -r "$artist" $file
            fi
        fi;
        if ! [ -z "$number" ]; then
            if [ "$number" == "nil" ]; then
                taffy --no-track $file
            elif [ "$number" == "y" ] || [ "$number" == "Y" ]; then
                taffy -n $n $file;
                ((n++))
            fi
        fi
    done
else
    echo "Paczka $package nie jest zainstalowana"
fi

taffy *.mp3 | less

