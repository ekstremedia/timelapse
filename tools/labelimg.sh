#!/bin/sh

if [ ! -f $1 ]; then
    echo "$1 not found"
    exit -1
fi

text=`identify -format "%[EXIF:DateTime]" $1`
width=`identify -format %w $1`
convert $1 -gravity southeast -pointsize 40 \
    -stroke black -strokewidth 4 -annotate 0 "${text}" \
    -stroke white -strokewidth 1 -fill white -annotate 0 "${text}" \
    "caption_$1"
