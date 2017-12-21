#!/bin/bash

name="$1"

t=$(ffmpeg -i "$name" 2>&1| grep Duration )
hh=${t#*: }; mm=${hh#*:}; ss=${mm#*:}
hh=${hh%%:*}; mm=${mm%%:*}; ss=${ss%%.*}

frame=$((hh*3600*25 + mm*60*25 + ss*25))
delay=$((frame / 10))
offset=$((delay/2))

ffmpeg -i "$name" -frames 1 -vf "select=not(mod($offset+n\,$delay)),scale=320:180,tile=3x3" "${name%.*}.png"
