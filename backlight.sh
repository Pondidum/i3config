#!/bin/bash

action=${1:-inc}
amount=${2:-"10"}

xbacklight -"$action" "$amount"

current="$(xbacklight -get)"

notify-send.sh \
  --replace-file=/tmp/backlight.notify \
  --hint="int:value:${current%.*}" \
  --icon="video-display" \
  "Brightness"
