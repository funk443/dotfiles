#!/bin/sh

while true; do
    volume=$(pamixer --get-volume-human)
    date=$(date +'%Y-%m-%d %H:%M:%S')
    echo "${volume} | ${date}"
    sleep 1
done
