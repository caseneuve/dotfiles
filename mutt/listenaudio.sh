# Last update: 10.04.18, 16:01:48 @manjaroi3

#!/bin/bash

#clear;
#mpv $1 & 
cp $1 /tmp/mutt_music.mp3 &&\
mocp -l /tmp/mutt_music.mp3

#xfce4-terminal -T mutt-audio -e "bash -c \"mpv $1; bash\"" - nie działa (nie widzi pliku w /tmp/)

