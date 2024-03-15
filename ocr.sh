#!/usr/bin/env bash

lang="eng"

file=$(mktemp --suffix .png)
rm "$file"

flameshot gui -p "$file" -s
mogrify -modulate 100,0 -resize 400% "$file"
tesseract -l eng+${lang} "$file" - | xsel -bi

notify-send "Text extracted"

