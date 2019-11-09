#!/bin/bash

# Path:        ~/.bin/urlview-handler.sh
# Created:     04.04.18, 11:48    @x200
# Last update: 2019-11-09, 22:26:55 @lenovo

# Doc: via Luke Smith github
# note: replacing feh with sxiv
# done: problem na współpracy z queuemv → argument sie nie rozwija, lecz cytuje się nazwa (należy cytuwać podwójnymi nawiasami)

ext="${1##*.}"
mpvFiles="mkv mp4 avi mov wmv flv ogg"
fehFiles="png jpg jpeg jpe gif"
wgetFiles="mp3 mp3?source=feed pdf"
em="email"
mpvscript=~/.scripts/mpvsoc
[[ $mpvscript =~ mpvsoc ]] && mpvargs="-v" || mpvargs=


downloader(){
    ROFI_ARGS="-theme i3on-window -monitor -2 -dmenu -p"
    answ=$(echo -e "yes\nno" | rofi $ROFI_ARGS "Download to ~/dwl [yes] or xdg-open [no]? ")
    case "${answ}" in
        no) nohup wget -O /tmp/file.$ext "$1" > /dev/null
            xdg-open /tmp/file.$ext &
            ;;
        yes) cd ~/dwl
             filename=$(basename "$1")
             nohup wget "$1" > /dev/null && notify-send "DOWNLOAD" "$filename --> ~/dwl"
             ;;
    esac
}

if grep slack <<< "$1" > /dev/null; then
    nohup xdg-open $1 > /dev/null &
elif grep -w $ext <<< "$fehFiles" > /dev/null; then
    # sxiv nie potrafi otwierać linków
    nohup feh -. -B -- "$1" > /dev/null &
elif grep "googleusercontent.com" <<< "$1" >/dev/null; then
    nohup feh -. -B -- "$1" > /dev/null &
elif grep -w $ext <<< "$mpvFiles" > /dev/null; then
    if [ -f $mpvscript ]; then
        nohup $mpvscript $mpvargs "$1" >/dev/null &
    else
        nohup mpv --loop --quiet "$1" > /dev/null &
    fi
elif grep -w $ext <<< "$wgetFiles" > /dev/null; then
    downloader "$1"
    # nohup wget -O /tmp/file.$ext "$1" > /dev/null
    # xdg-open /tmp/file.$ext &
elif grep "youtube\.\|youtu\.be" <<< "$1" > /dev/null; then
    if [ -f $mpvscript ]; then
        nohup $mpvscript "$mpvargs" "$1" &
    else
        nohup mpv "$1" > /dev/null &
        notify-send "failur xxx"
    fi
elif grep vimeo <<< "$1" > /dev/null; then
    nohup mpv "$1" > /dev/null &
elif grep "https://docs\.google\.com/document" <<< "$1" > /dev/null; then
    nohup ~/.dotfiles/bin/gdocs-downloader.sh $1 > /dev/null &
else
    nohup qutebrowser "$1" > /dev/null &
fi

