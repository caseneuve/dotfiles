# Last update: 15.01.18, 12:47:13 @x200

#!/bin/bash

clear;
mpv $1

#xfce4-terminal -T mutt-audio -e "bash -c \"mpv $1; bash\"" - nie działa (nie widzi pliku w /tmp/)
