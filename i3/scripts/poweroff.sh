#!/bin/bash

GLYPH=
THEME=~/.config/rofi/i3on-window.rasi
echo "$GLYPH     "

case $BLOCK_BUTTON in
    #1 = Left, 2 = Middle, 3 = Right, 4 = Scroll Up, 5 = Scroll Down
    1) systemctl suspend -i;;
    3) select=$(echo -e "tak    \nnie" | rofi -theme $THEME -dmenu -p "$GLYPH   Chcesz wyłączyć komputer?" )
       if [[ $select == "tak" ]]; then
           systemctl poweroff -i
       else
           exit
       fi
       ;;
    # 3) pactl set-sink-volume 0 50%  && pkill -RTMIN+1 i3blocks;;
esac

