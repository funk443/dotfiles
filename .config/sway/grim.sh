#!/bin/bash

set -e

dir="$HOME/Pictures/grim"
mkdir -p "$dir"

output_file="${dir}/$(date +%Y%m%d-%H%M%S).png"

if [ "$1" = "--region" ]; then
    region=$(slurp) || { notify-send -t 1000 "Canceled."; exit 1; }
    grim -g "$region" "$output_file"
else
    grim "$output_file"
fi

wl-copy < "$output_file"
notify-send -t 1000 "Screenshot saved and copied."
