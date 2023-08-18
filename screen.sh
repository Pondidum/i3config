#!/bin/sh

readonly SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

mode=${1:-internal}

internal_output="eDP1"
external_output=$(xrandr \
  | grep ' connected ' \
  | sed 's/^\(.*\) connected.*/\1/g' \
  | grep -v "$internal_output" \
  | tail -1)


echo "==> Switching to $mode"
echo "    Internal: $internal_output"
echo "    External: $external_output"

message=""

if [ "$mode" = "internal" ]; then
  xrandr \
    --output "$internal_output" --auto \
    --output "$external_output" --off
  message="Internal Display Only"

elif [ "$mode" = "external" ]; then
  xrandr \
    --output "$internal_output" --off \
    --output "$external_output" --auto
  message="External Display Only"

elif [ "$mode" = "extend-r" ]; then
  xrandr \
    --output "$internal_output" --auto \
    --output "$external_output" --auto --right-of "$internal_output"
  message="Extending to External Display"

elif [ "$mode" = "extend-l" ]; then
  xrandr \
    --output "$internal_output" --auto \
    --output "$external_output" --auto --left-of "$internal_output"
  message="Extending to External Display"

elif [ "$mode" = "clone" ]; then
  xrandr \
    --output "$internal_output" --auto \
    --output "$external_output" --auto --same-as "$internal_output"
  message="Cloning to External Display"
fi

"$SCRIPT_DIR/notify-send.sh" \
  --replace-file=/tmp/screens.notify \
  --icon=video-display \
  "Display Output Changed" \
  "$message"
