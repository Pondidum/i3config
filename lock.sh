#!/bin/bash

dimensions=$(xdpyinfo | awk '/dimensions/{print $2}')
lockscreen="$HOME/.config/i3/img/$dimensions.png"

if ! [ -e "$lockscreen" ]; then
    image="$HOME/.config/i3/img/source.png"
    convert -scale "$dimensions" "$image" "$lockscreen"
fi

i3lock -i "$lockscreen"
