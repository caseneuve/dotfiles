#!/bin/bash

# Path:        ~/.dotfiles/bin/monitory-UP.sh
# Created:     06.07.18, 09:47    @toshiba
# Last update: 18.09.18, 14:23:54 @x200

# Doc: default setting for 2 monitors (primary down, secondary up)
#xrandr --current | grep -A 1 primary | awk -F"x" 'NR==2 {gsub(/^ */,""); print $1}'

intern=$(xrandr --listmonitors | awk 'NR==2 {print $(NF)}')
#intern=$(xrandr --current | awk 'NR==2 {print $1}')

inres=$(xrandr --current | grep "+$\|+ " | awk ' NR==1 {print $1}')

[[ $(xrandr --listmonitors | awk 'NR==1 {print $2}') > 1 ]] &&\
    extern=$(xrandr --listmonitors | awk 'NR==3 {print $(NF)}') ||\
        extern=$(xrandr --current | grep -v $intern | grep -A 1 " connected" | awk 'NR==1 {print $1}')
#extern=$(xrandr | grep " connected" | awk 'NR==2 {print $1}')

exres=$(xrandr --current | grep "+$\|+ " | awk ' NR==2 {print $1}')
posy=$(echo $exres | sed 's/[0-9]*x//')

if [[ $(xrandr | grep "$extern disconnected") ]]; then
    xrandr --output "$intern" --auto --output "$extern" --off
else
    xrandr --output "$intern" --primary --mode "$inres" --pos 0x$posy --rotate normal --output "$extern" --mode "$exres" --pos 0x0 --rotate normal
fi

if [ -n $extern ] && [ -n $intern ]; then
    ~/.fehbg;
    pkill dunst && dunst &
fi
