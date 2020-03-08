#!/bin/bash

mode=${1:-toggle}
amount=${2:-"5%"}

sink=$(pactl list short sinks | grep RUNNING | cut -f1)
sink=${sink:-"0"}

echo "==> Changing Volume"
echo "    Mode:   $mode"
echo "    Amount: $amount"
echo "    Sink:   $sink"

if [ "$mode" = "toggle" ]; then
  pactl set-sink-mute "$sink" toggle

elif [ "$mode" == "raise" ]; then
  pactl set-sink-volume "$sink" "+$amount"

elif [ "$mode" == "lower" ]; then
  pactl set-sink-volume "$sink" "-$amount"

fi

sink_info=$(pactl list sinks | grep -A20 "Sink #$sink")
volume=$(echo "$sink_info" | awk '/Volume: front/{ print $5 }' | sed 's/[%|,]//g')
muted=$(echo "$sink_info" | awk '/Mute:/{ print $2 }')

icon="audio-volume-medium"
message="Volume: $volume"

if [ "$muted" = "yes" ]; then
  message="Volume: muted"
  icon="audio-volume-muted"

elif [ "$volume" -lt 33 ]; then
  icon="audio-volume-low"

elif [ "$volume" -gt 66 ]; then
  icon="audio-volume-high"

fi

notify-send.sh \
  --replace-file=/tmp/volume.notify \
  --hint="int:value:$volume" \
  --icon="$icon" \
  "Volume" \
  "$message"
