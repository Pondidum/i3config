#!/bin/bash

dimensions=$(xdpyinfo | awk '/dimensions/{print $2}')
lockscreen="$HOME/.config/i3/img/$dimensions.png"

if ! [ -e "$lockscreen" ]; then
    image="$HOME/.config/i3/img/source.png"
    convert -scale "$dimensions" "$image" "$lockscreen"
fi

python3 "$HOME/.config/i3/kb.py" lock || true

i3lock -i "$lockscreen" -n

python3 "$HOME/.config/i3/kb.py" unlock || true
