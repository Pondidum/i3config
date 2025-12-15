#!/bin/bash

screenshot="/tmp/screenshot.png"
lockscreen="/tmp/screenshot.blurred.png"

rm -f "$screenshot"
flameshot full --path "/tmp/screenshot.png"
convert -scale 10% -blur 0x0.5 -resize 1000% "$screenshot" "$lockscreen"

i3lock -i "$lockscreen" -n -t
