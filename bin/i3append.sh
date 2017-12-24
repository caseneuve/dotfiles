#!/bin/bash

loc=~/.i3/config
cfg=~/.dotfiles/i3/config
ap=~/.dotfiles/i3/append-config
x200=~/.dotfiles/i3/x200-conf
man=~/.dotfiles/i3/manjaro-conf
len=~/.dotfiles/i3/lenovo-conf

cp "$cfg" "$ap"
echo "# ostatni update: $(date '+%d.%m.%y, %H:%M')" >> "$ap"

case $HOSTNAME in
  (manjaroi3) cat "$man" >> "$ap";  cp "$ap" "$loc";;
  (x200) cat "$x200" >> "$ap"; cp "$ap" "$loc";;
  (lenovo) cat "$len" >> "$ap"; cp "$ap" "$loc";;
esac 

rm "$ap"

# if [ $HOSTNAME == "manjaroi3" ]; then
#     cat "$man" >> "$ap"
#     cp "$ap" "$loc"
# fi && \

# if [ $HOSTNAME == "x200" ]; then
#     cat "$x200" >> "$ap"
#     cp "$ap" "$loc"
# fi && \

# if [ $HOSTNAME == "lenovo" ]; then
#     cat "$len" >> "$ap"
#     cp "$ap" "$loc"
# fi && \

i3-msg reload
