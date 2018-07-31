#! /usr/bin/env bash

GPHOTO2=gphoto2
CURL=curl
NAMELAPSE=$1
FILENAME="$NAMELAPSE"_"%Y%m%d_%05n.cr2" # FIXA DS
INTERVAL=$2
mkdir -p $1/

if ! type $GPHOTO2 >/dev/null 2>&1; then echo $GPHOTO2 not installed; exit 1; fi
if [ $INTERVAL > 0 ] 
then echo Intervallmode! Satt til å ta bilete kvart $INTERVAL sekund.
fi
echo Oppretter og lagrer bilete på $NAMELAPSE/
echo ""
echo Startar timelapse... lukka te!
gphoto2 --capture-image-and-download --filename $NAMELAPSE/$FILENAME --interval $INTERVAL
