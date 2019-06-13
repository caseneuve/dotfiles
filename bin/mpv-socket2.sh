#!/bin/bash

#* -------------------------------------------------------------------
# Path:        ~/.dotfiles/bin/mpv-socket2.sh
# Created:     2019-06-05, 11:06    @x200
# Last update: 2019-06-13, 10:20:33 @x200
# Doc:
# Todos:       [ ] 05/06: cant pass file with spaces in name
#              [ ]        notifications
#              [ ]        position on playlist
#              [ ]        add second socket for audio
#              [ ]        add opt to jump next/prev on playlist
#---------------------------------------------------------------------

#* initial conditions
! [[ $(pacman -Q jq) ]] && exit 1
SOC=/tmp/mpv #; ! [[ -S $SOC ]] && exit 1

#* FUNCS
#** usage
usage(){
    cat <<EOF
Usage:  $(basename $0) [-pSish] [-j <seconds>] [-v|-a <address>]

Options:
 -v URL/PATH  mpv play video (or append to playlist)
              from URL/PATH
 -a URL/PATH  same as -v but audio instead of video
 -i           print current stream info
 -q           quit mpv
 -P           toggle pause
 -j INT       jump INT seconds forward
              (or backward for negative number)
 -d NUM       stream speed (where 1 = normal, 0.5 = 50%,
              1.2 = 20% faster than normal, etc.)

EOF
}

#** socket get
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

#** socket set
socket_set(){
    property=$1
    value=$2
    echo "{ \"command\": [\"set_property\", \"$property\", \"$value\"] }" \
        | socat - $SOC >/dev/null
}

#** command
command(){
    #*** convert secs - helper
    convertsecs() {
        if [[ -n $1 ]]; then
            ((h=${1}/3600))
            ((m=(${1}%3600)/60))
            ((s=${1}%60))
            printf "%02d:%02d:%02d\n" $h $m $s
        else return 1
        fi
    }

    #*** commands
    case $1 in
        time-pos) convertsecs $(socket_get string $1 cut) ;;
        time-remaining) convertsecs $(socket_get string $1 cut) ;;
        playlist-pos) pos=$(socket_get string $1)
                      ((pos++))
                       echo $pos
                       ;;
        playlist-count) socket_get string $1 ;;
        filtered-metadata) socket_get property $1 ;;
        media-title) socket_get property $1 ;;
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
        speed) socket_get property $1 ;;
        set-pos) socket_set time-pos $2
    esac
}

#** metadata
metadata(){
    jq ".$1" -r <<< $(command filtered-metadata)
}

#** loop
loop(){
    while ps -p $1 > /dev/null
    do
        read X <<< $(command status)
        if [[ $X = PLAY ]]; then
            echo hook:module/mpv1 >> /tmp/polybar-ipc-primary
            prev=PLAY
            sleep 5
        elif ! [[ $prev = PAUSE ]]; then
            echo hook:module/mpv1 >> /tmp/polybar-ipc-primary
            prev=PAUSE
        else
            sleep 1
        fi
    done
    echo hook:module/mpv2 >> /tmp/polybar-ipc-primary
}

#** play
play(){
    if [[ $(command time-pos) ]]; then
        if $(echo "{ \"command\": [ \"loadfile\", \"$2\", \"append-play\" ] }" \
                 | socat - $SOC >/dev/null & disown)
        then notify-send -u low "Video has been appended to playlist" &
        fi
    else
        if [[ -n "$2" ]]; then
            [[ $1 = audio ]] && ARG=--no-video
            input="${@:2}"
            [[ "$input" =~ http ]] && address=$input || address=$(readlink -f "$input")

            notify-send -u low "Video is loading..." &

            mpv "$address" \
                --input-ipc-server=$SOC \
                --save-position-on-quit \
                --really-quiet \
                $ARG &  # 2>/dev/null //disown

            loop $! & #disown
        fi
    fi
}

#** info
info(){
    if [[ $(command time-pos) ]]
    then
        speed=$(command speed)
        [[ $speed = 1 ]] && speed= || speed=" x$speed"
        # what="$(command media-title)";
        # [[ $what = null ]] && what=$(basename $(command current))

        printf "%.1s %s %s [%d/%d]%s" \
               $(command medium) \
               $(command status) \
               $(command time-pos) \
               $(command playlist-pos) \
               $(command playlist-count) \
               "$speed"
    else exit 1
    fi
}


#** polybar info
polybar_info(){
    if [[ $(command time-pos) ]]; then
        speed=$(command speed)
        [[ $speed = 1 ]] && speed= || speed=" x$speed"
        [[ $(command status) = PLAY ]] && color="#ffffff" || color="-"
        [[ $(command medium) = VIDEO ]] && icon="%%{T4}%%{T-}" || icon="%%{T4}%%{T-}"
            printf "%%{F$color}$icon %s [%d/%d]%s" \
               $(command time-pos) \
               $(command playlist-pos) \
               $(command playlist-count) \
               "$speed"
    else exit 1
    fi
}


#** main
main(){
    while getopts 'PpnucqQishv:a:j:d:t:' flag; do
        shift
        case "$flag" in
            s) if [[ $(command time-pos) ]]; then
                   command status
               else
                   exit 1
               fi ;;
            v) play video "${@}" ;;
            a) play audio "${@}" ;;
            q) echo '{"command": ["quit"] }' | socat - $SOC >/dev/null
               ;;
            Q) echo '{"command": ["stop"] }' | socat - $SOC >/dev/null
               ;;
            c) echo '{"command": ["cycle", "pause"] }' | socat - $SOC >/dev/null
               ;;
            j) echo "{\"command\": [\"seek\", $OPTARG] }" \
                     | socat - $SOC >/dev/null
               ;;
            n) echo '{"command": ["playlist-next", "force"] }' \
                     | socat - $SOC >/dev/null
               ;;
            p) echo '{"command": ["playlist-prev", "force"] }' \
                     | socat - $SOC >/dev/null
               ;;
            d) echo "{\"command\": [\"set_property\", \"speed\", $OPTARG] }" \
                    | socat - $SOC >/dev/null
               ;;
            i) info ;;
            P) polybar_info ;;
            t) socket_set time-pos $OPTARG ;;
            h|*) usage ;;
        esac
    done
}

#* EXECUTE
main $@
#command speed
