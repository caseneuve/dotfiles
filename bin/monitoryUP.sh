#!/bin/bash

# Path:        ~/.dotfiles/bin/monitory-UP.sh
# Created:     06.07.18, 09:47    @toshiba
# Last update: 07.07.18, 12:21:00 @toshiba

# Doc: default setting for 2 monitors (primary down, secondary up)

intern=$(xrandr --listmonitors | awk 'NR==2 {print $(NF)}')
inres=$(xrandr --current | grep "\*" | awk ' NR==1 {print $1}')
extern=$(xrandr --listmonitors | awk 'NR==3 {print $(NF)}')
exres=$(xrandr --current | grep "\*" | awk ' NR==2 {print $1}')
posy=$(echo $exres | sed 's/[0-9]*x//')

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --primary --mode "$inres" --pos 0x$posy --rotate normal --output "$extern" --mode "$exres" --pos 0x0 --rotate normal
    ~/.fehbg
fi

