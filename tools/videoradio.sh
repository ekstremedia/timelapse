#! /usr/bin/env bash

streamripper http://lyd.nrk.no/nrk_radio_klassisk_mp3_h -l 60 -a radio.mp3
mpg123 -w radio.wav radio.mp3
ffmpeg -r 25 -pattern_type glob -i 'oldjob/Nytltest2/resized/*.jpg' -c:v copy -shortest doutput.avi -i radio.wav -y

