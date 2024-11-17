#!/bin/sh

while true; do
    battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    volume=$(pamixer --get-volume-human)
    date=$(date +'%Y-%m-%d %H:%M:%S')
    echo "$battery_percentage% $battery_status | ${volume} | ${date}"
    sleep 1
done
