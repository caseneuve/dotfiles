#!/bin/bash

# Path:        ~/.dotfiles/bin/taffy.sh
# Created:     01.05.18, 12:06    @x200
# Last update: 05.06.18, 10:34:12 @manjaroi3

# Doc: script to facilitate using of taffy (tagging cli app for audio files)

# colors
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)

# file to edit
file=$1

# code:
clear

if [ -f "$file" ]; then
    echo "${yel}${bold}### Executing _taffy-helper_ script ${normal}"
    echo "##  Value 'nil' clears the tag, empty value does nothing"
    echo
    echo "file:    ${bold}${gre}$(basename "$file")${normal}"
    taffy "$file" | tail -n +2
    read -p "${bold}${red} →  What is the ${yel}ALBUM${red} name?${normal} ....... " album
    read -p "${bold}${red} →  What is the ${yel}ARTIST ${red}name?${normal} ...... " artist
    read -p "${bold}${red} →  Do you have any ${yel}COMMENTS?${normal} ..... " comment
    read -p "${bold}${red} →  Specify ${yel}GENRE:${normal} ................ " genre
    read -p "${bold}${red} →  What is the ${yel}TITLE${red} of the track?${normal} " title
    read -p "${bold}${red} →  What is the ${yel}TRACK${red} number?${normal} ..... " track

    # album tag
    if ! [ -z "$album" ]; then
        if [ "$album" == "nil" ]; then
            taffy --no-album "$file"
        else
            taffy -l "$album" "$file"
        fi
    fi

    # artist tag
    if ! [ -z "$artist" ]; then
        if [ "$artist" == "nil" ]; then
            taffy --no-artist "$file"
        else
            taffy -r "$artist" "$file"
        fi
    fi

    # comment tag
    if ! [ -z "$comment" ]; then
        if [ "$comment" == "nil" ]; then
            taffy --no-comment "$file"
        else
            taffy -c "$comment" "$file"
        fi
    fi

    # genre tag
    if ! [ -z "$genre" ]; then
        if [ "$genre" == "nil" ]; then
            taffy --no-genre "$file"
        else
            taffy -g "$genre" "$file"
        fi
    fi

    # title tag
    if ! [ -z "$title" ]; then
        if [ "$title" == "nil" ]; then
            taffy --no-title "$file"
        else
            taffy -t "$title" "$file"
        fi
    fi

    # track tag
    if ! [ -z "$track" ]; then
        if [ $track == "nil" ]; then
            taffy --no-track "$file"
        else
            taffy -n "$track" "$file"
        fi
    fi

    # print the result
    echo
    echo "file:    ${bold}${yel}$(basename "$file")${normal}"
    taffy "$file" | tail -n +2
    sleep 1.5s
else
    echo "File was not specified"
fi

