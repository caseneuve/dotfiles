#!/bin/bash

# Path:        ~/.dotfiles/bin/mpv-socket2.sh
# Created:     2019-06-05, 11:06    @x200
# Last update: 2019-06-05, 12:46:20 @x200
# Doc:

! [[ $(pacman -Q jq) ]] && exit 1
SOC=/tmp/mpv; ! [[ -S $SOC ]] && exit 1

socket_get(){
    case $1 in
        property) verb=get_property ;;
        string) verb=get_property_string ;;
    esac
    result=$(echo "{ \"command\": [\"$verb\", \"$2\"] }" \
                 | socat - $SOC 2>/dev/null \
                 | jq .data -r )
    [[ -n $3 ]] && result=$(cut -d'.' -f 1 <<< $result)
    echo $result
}

command(){
    case $1 in
        time-pos) socket_get string $1 cut ;;
        time-remaining) socket_get string $1 cut ;;
        playlist-pos) socket_get string $1 ;;
        playlist-count) socket_get string $1 ;;
        filtered-metadata) socket_get property $1 ;;
        playlist) socket_get property $1 | jq .[].filename -r ;;
        current)
            socket_get property playlist |\
                jq '.[] | select (.| has("current")) | .filename' -r
            ;;
        status) [[ $(socket_get property pause) = "false" ]] \
                    && echo "PLAY" || echo "PAUSE"
                ;;
        medium) [[ $(socket_get property video) = "false" ]] \
                    && echo "AUDIO" || echo "VIDEO"
                ;;
    esac
}

metadata(){
    jq ".$1" -r <<< $(command filtered-metadata)
}

convertsecs() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

main(){
    while :
    do
        read X <<< $(command status)
        if [[ $X = PLAY ]]; then
            printf "[%s] [%s] | %s  --  %s\n" \
                   $(command medium) \
                   $(command status) \
                   $(convertsecs $(command time-pos)) \
                   "$(metadata Artist)"
            sleep 1
        elif ! [[ $prev = PAUSE ]]; then
            printf "[%s] [%s] | %s  --  %s\n" $(command medium) $(command status) $(convertsecs $(command time-pos)) "$(metadata Artist)"
            prev=PAUSE
        fi
    done
}
