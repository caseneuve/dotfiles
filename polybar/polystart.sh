#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get monitor names
PRIMARY=$(xrandr -q | awk '/connected primary/ {print $1}')
SECONDARY=$(xrandr -q | awk '/ connected [0-9]/ {print $1}')

# Launch bar1 and bar2
MONITOR=$PRIMARY polybar -r primary &
ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-primary

if [[ -n $SECONDARY ]]; then
    EXTERNAL=$SECONDARY polybar -r secondary &
    ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-secondary
fi

#notify-send "polybar" "Bars launched..."
