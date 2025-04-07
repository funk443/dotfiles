#!/bin/bash

set -e

dir="$HOME/Pictures/grim"
mkdir -p "$dir"

output_file="${dir}/$(date +%Y%m%d-%H%M%S).png"

{[ "$1" = "--region" ] && grim -g "$(slurp)" "$output_file"} || grim "$output_file"
wl-copy < "$output_file"

notify-send -t 1000 "Screenshot saved and copied."
