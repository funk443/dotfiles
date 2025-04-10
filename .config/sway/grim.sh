#!/bin/bash

set -e

dir="$HOME/Pictures/grim"
mkdir -p "$dir"

output_file="${dir}/$(date +%Y%m%d-%H%M%S).png"

if [ "$1" = "--region" ]; then
    grim -g "$(slurp)" "$output_file"
else
    grim "$output_file"
fi

wl-copy < "$output_file"
notify-send -t 1000 "Screenshot saved and copied."
