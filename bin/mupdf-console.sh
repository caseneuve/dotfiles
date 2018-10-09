#!/bin/bash

# Path:        ~/scr/mupdf-console.sh
# Created:     09.10.18, 17:45    @lenovo
# Last update: 09.10.18, 19:22:19 @lenovo
# >> DOC:
# duplicate a chosen pdf file and control the navigation with the console 

# >> TODOS: 
# done: 1. select file
# 2. duplicate it
# todo: save the xdotool id
# todo: find pid and path (ps aux, awk)
# todo: open selected file at the same wksp


# >> VARIABLES: 
mupdfs=$(xdotool search --classname mupdf)
titles=()
pids=()

if [[ -n $mupdfs ]]; then
    for i in $mupdfs; do
        titles+=("$(xdotool getwindowname $i)")
        pids+=("$i")
    done
else
    echo "No mupdf files opened." && exit 
fi

len=${#titles[@]}

# >> FUNCS
choose_prompt(){
    clear
    echo -e "MuPDF console v0.1 alpha\n"
    echo "Choose a file to duplicate: "
    for (( c=0; c<len; c++ )); do
        echo " [$((c+1))] ${titles[c]%.pdf - *}"
    done
    if [[ -n $1 ]]; then
        echo -e "\n … Invalid input: $1\n"
    else
        echo
    fi
}

# >> RUN:
choose_prompt

while true; do
    read -p "$(tput blink) >$(tput sgr0) " choice
    if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
        choose_prompt "$choice"
    else
        if (( 0 < choice )) && (( choice < ((len + 1)) )); then
            path=$(ps aux | grep "${titles[choice-1]%.pdf - *}" | grep -v grep | grep -v "/bin/sh -c set"| awk 'NR==1 {print $13}')
            mupdf "$path" &
            break
        else
            choose_prompt "$choice"
        fi
    fi
done

exit
