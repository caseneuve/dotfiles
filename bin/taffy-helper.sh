#!/bin/bash

# Path:        ~/.dotfiles/bin/taffy.sh
# Created:     01.05.18, 12:06    @x200
# Last update: 01.05.18, 13:23:47 @x200

# Doc: script to facilitate using of taffy (tagging cli app for audio files)

bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
file=$1

clear

if [ -f "$file" ]; then
    echo "${yel}${bold}### Executing _taffy-helper_ script ###${normal}"
    echo "### Value 'nil' clears the tag, empty value does nothing"
    echo
    taffy "$file"
    read -p "${bold} →  What is the ALBUM name?${normal} ....... " album
    read -p "${bold} →  What is the ARTIST name?${normal} ...... " artist
    read -p "${bold} →  Do you have any COMMENTS?${normal} ..... " comment
    read -p "${bold} →  Specify GENRE:${normal} ................ " genre
    read -p "${bold} →  What is the TITLE of the track?${normal} " title
    read -p "${bold} →  What is the TRACK number?${normal} ..... " number

    # album tag
    if ! [ -z "$album" ]; then
        if [ $album == "nil" ]; then
            taffy --no-album "$title"
        else
            taffy -l "$album" "$file"
        fi
    fi

    # artist tag
    if ! [ -z "$artist" ]; then
        if [ $artist == "nil" ]; then
            taffy --no-artist "$file"
        else
            taffy -r "$artist" "$file"
        fi
    fi

    # comment tag
    if ! [ -z "$comment" ]; then
        if [ $comment == "nil" ]; then
            taffy --no-comment "$file"
        else
            taffy -c "$comment" "$file"
        fi
    fi

    # genre tag
    if ! [ -z "$genre" ]; then
        if [ $genre == "nil" ]; then
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
    taffy "$file"
else
    echo "File was not specified"
fi

