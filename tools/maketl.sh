#! /usr/bin/env bash
cd /home/terje
echo Lagar tl2/...
mkdir tl2
echo Kopierer filer fra images/ til tl2/ ...
cp -R testtl/*.jpg tl2/
cd tl2
echo "tl2/"
mkdir renamed
echo Lagar renamed/...
counter=1
echo Fiksar filnamn...
#ls -1tr *.jpg | while read filename; do cp $filename renamed/$(printf %05d $counter)_$filename; ((counter++)); done
cp -R *.jpg renamed/
cd renamed
echo "tl2/renamed/";
echo "Lagar resized/";
mkdir resized
echo "Nedskalerer..."
mogrify -path resized -resize 1920x1080! *.jpg # If you want to keep the aspect ratio, remove the exclamation mark (!)
# You can also use the mogrify from graphicsmagick package which is faster, I use it in combination with the command "parallel" in order to utilize all of my CPU cores and perform the resize much faster.
# Of course, you can use the command "parallel" with the imagemagick mogrify
# parallel --progress gm mogrify -quality 100 -output-directory resized -resize 1920x1080! ::: *.JPG # Similar as before, remove the exclamation mark in order to keep the aspect ratio.
cd resized
echo "tl2/renamed/resized/"
echo "Koder video..."
ffmpeg -r 25 -pattern_type glob -i '*.jpg' -c:v copy ../../../output.avi -y
