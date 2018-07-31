#! /usr/bin/env bash
# Umake.tl 0.2
# ./umaketl.sh folderwithraws/
echo Terje-timelapse 0.2
if [ -z "$1" ]; then echo "Kommando: ./umaketl.sh <navn_på_mappe_med_cr2>"; exit 1; fi
folder=$1
date=$(date)
orginalfolder=$folder
antbild=$(ls -l $folder | wc -l)
GPHOTO2=gphoto2
if ! type $GPHOTO2 >/dev/null 2>&1; then echo $GPHOTO2 not installed; exit 1; fi
MPG123=mpg123
if ! type $MPG123 >/dev/null 2>&1; then echo $MPG123 not installed; exit 1; fi
MOGRIFY=mogrify
if ! type $MOGRIFY >/dev/null 2>&1; then echo $MOGRIFY not installed; exit 1; fi
FFMPEG=ffmpeg
if ! type $FFMPEG >/dev/null 2>&1; then echo $FFMPEG not installed; exit 1; fi
ST=streamripper
if ! type $ST >/dev/null 2>&1; then echo $ST not installed; exit 1; fi
CJPEG=cjpeg
if ! type $CJPEG >/dev/null 2>&1; then echo $CJPEG not installed; exit 1; fi

echo Lagar timelapse av $antbild bilete...
echo Lagar jobtl/$folder/..
#rm -rf jobtl/$folder
mkdir -p jobtl/$folder
echo Eksporterar ut jpg-bilete frå raw-filane...
for i in $folder/*.cr2; do dcraw -c -w -h $i | $CJPEG -quality 80 > /home/terje/jobtl/$i.jpg; done 
echo Kopierar filar fra $1/ til jobtl/ ...
#cp -v -R $1/*.jpg jobtl/$folder
echo "Lagar jobtl/$folder/resized/";
mkdir -p jobtl/$folder/resized
echo "Nedskalerer..."
$MOGRIFY -path jobtl/$folder/resized -resize 1920x1080! jobtl/$folder/*.jpg # If you want to keep the aspect ratio, remove the exclamation mark (!)
echo Fjerner gamle bilder...
rm -rf jobtl/$folder/*.jpg
# You can also use the mogrify from graphicsmagick package which is faster, I use it in combination with the command "parallel" in order to utilize all of my CPU cores and perform the resize much faster.
# Of course, you can use the command "parallel" with the imagemagick mogrify
# parallel --progress gm mogrify -quality 100 -output-directory resized -resize 1920x1080! ::: *.JPG # Similar as before, remove the exclamation mark in order to keep the aspect ratio.
echo "/jobtl/$folder/resized/"
echo "Koder video..."
#ffmpeg -r 25 -pattern_type glob -i 'jobtl/'$folder'/resized/*.jpg' -c:v copy output.avi -y
$SR http://lyd.nrk.no/nrk_radio_klassisk_mp3_h -l 120 -a radio.mp3
$MPG123 -w radio.wav radio.mp3
#ffmpeg -r 25 -pattern_type glob -i "jobtl/$folder/resized/*.jpg" -i radio.wav -c:v mjpeg -q:v 4 output.avi -y
$FFMPEG -r 25 -pattern_type glob -i "jobtl/$folder/resized/*.jpg" -c:v copy -shortest output.avi -i radio.wav -y
cp -r output.avi /var/www/html/tl/timelapse_$(date +%Y-%m-%d).avi
nao=$(date)
echo "Ferdig! :)"
echo "Starta $date"
echo "Dato:  $nao"
