#!/bin/bash

var1="$1"

fila=`stat --printf="%n\n" $(ls -tr $(find $1 -type f)) | sort -nr | head -n 1`
echo Den siste fila er $fila.. konverterer...
dcraw -c -w -h $fila | cjpeg -quality 80 > /home/terje/webcam.jpg
echo Konvertert! http://timelap1/tl.jpg
