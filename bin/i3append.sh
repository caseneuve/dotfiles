#!/bin/bash

# Path: ~/.dotfiles/bin/i3append.sh
# Created:     04.01.18, 18:43    @x200
# Last update: 2019-10-21, 06:04:08 @x200

# Doc:  Appends  i3config  file  (main) with  local  files  containing
# different settings  for different machines, then  executes i3 reload
# command (works only  for key bindings, otherwise  execute i3 restart
# from keyboard shortcut/command line)

loc=~/.i3/config
cfg=~/.dotfiles/i3/config
ap=~/.dotfiles/i3/append-config
x200=~/.dotfiles/i3/x200-conf
tosh=~/.dotfiles/i3/toshiba-conf
len=~/.dotfiles/i3/lenovo-conf

cp "$cfg" "$ap"
echo "# Last append: $(date '+%d.%m.%y, %H:%M:%S') @$HOSTNAME" >> "$ap"

case $HOSTNAME in
  (toshiba) cat "$tosh" >> "$ap";  cp "$ap" "$loc";;
  (x200) cat "$x200" >> "$ap"; cp "$ap" "$loc";;
  (lenovo) cat "$len" >> "$ap"; cp "$ap" "$loc";;
esac 

rm "$ap"

i3-msg -q reload
notify-send -t 1500 -u critical "i3" "config reloded!"
