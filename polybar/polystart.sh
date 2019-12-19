#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get monitor names
PRIMARY=$(xrandr -q | awk '/connected primary/ {print $1}')
SECONDARY=$(xrandr -q | awk '/ connected [0-9]/ {print $1}')
WLAN=$(ip route | awk '/^default/ { print $5 ; exit }')
BATTERY=$(ls -1 /sys/class/power_supply/ | grep -o "BAT[0-9]")
ADAPTER=$(ls -1 /sys/class/power_supply/ | grep -o "AC.*$")
# Launch bar1 and bar2
MONITOR=$PRIMARY WLAN=$WLAN BATTERY=$BATTERY ADAPTER=$ADAPTER polybar -q -r primary &
ln -sf /tmp/polybar_mqueue.$! /tmp/polybar-ipc-primary

if [[ -n $SECONDARY ]]; then
    EXTERNAL=$SECONDARY WLAN=$WLAN BATTERY=$BATTERY ADAPTER=$ADAPTER polybar -q -r secondary &
    ln -sf /tmp/polybar_mqueue.$! /tmp/polybar-ipc-secondary
fi

