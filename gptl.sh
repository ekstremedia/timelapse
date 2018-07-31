#! /usr/bin/env bash
# GPTL 0.3
echo "GPTL 0.2 av Terje Nesthus - terje@ekstremedia.no"
if [ -z "$1" ]; then echo "Kommando: ./gptl.sh <navn_på_prosjekt> [intervalnr]"; exit 1; fi
GPHOTO2=gphoto2
NAMELAPSE=$1
DF="$NAMELAPSE"/"%Y%m%d"
mkdir -p $DF/
FILENAME="$DF"_"%Y%m%d%05n.cr2" # FIXA DS
# FILENAME="$NAMELAPSE"_"%Y%m%d_%05n.cr2" # FIXA DS
INTERVAL=$2

if ! type $GPHOTO2 >/dev/null 2>&1; then echo $GPHOTO2 not installed; exit 1; fi
if [ $INTERVAL > 0 ] 
then echo Intervallmode! Satt til å ta bilete kvart $INTERVAL sekund.
fi
echo Oppretter og lagrer bilete på $NAMELAPSE/
echo ""
echo Startar timelapse... lukka te!
$GPHOTO2 --capture-image-and-download --filename $NAMELAPSE/$FILENAME --interval $INTERVAL 

