#!/usr/bin/env bash
#
# Usage:
# ./mov2gif.sh 20 1280 input.mov output.gif
#
# $1 fps
# $2 width
# $3 input video file
# $4 output gif file
#

palette="/tmp/palette.png"
filters="fps=$1,scale=$2:-1:flags=lanczos,setpts=0.7*PTS"

rm -f $palette

ffmpeg -i $3 -vf "$filters,palettegen" -y $palette
ffmpeg -i $3 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $4
