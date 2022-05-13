#!/bin/bash

readonly SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

action=${1:-"+"}
amount=${2:-"10"}

value=$(brightnessctl --machine-readable s "${amount}%${action}" \
  | cut -d "," -f 4 \
  | sed 's/%//g')

"$SCRIPT_DIR/notify-send.sh" \
  --replace-file=/tmp/backlight.notify \
  --hint="int:value:${value%.*}" \
  --icon="video-display" \
  "Brightness"
