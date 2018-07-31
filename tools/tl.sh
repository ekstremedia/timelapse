#! /usr/bin/env bash

# stop virtual filesystem mounts that may prevent usb camera access
gvfs-mount -s gphoto2

GPHOTO2=gphoto2
CURL=curl

if ! type $GPHOTO2 >/dev/null 2>&1; then echo $GPHOTO2 not installed; exit 1; fi
if ! type $CURL >/dev/null 2>&1; then echo $CURL not installed; exit 1; fi

# for all supported config settings, run gphoto2 --list-all-config
DELAYBETWEENSHOTS=10
PROJECTNAME="timelap1-nyttaar_"
CAMERAOPTS="--set-config autoexposuremode=1 --set-config iso=100 --set-config exposurecompensation=0 --set-config"

tall=0000
# test if camera is online and reachable
$GPHOTO2 --summary >/dev/null
if [ "$?" = "0" ]
then
	let filecount=$FTPEVERYNTHFILE-1
	while true
	do
		/bin/date
		# SHOTNAME is used in the hook script
		let tall=tall+1
		export SHOTNAME="$PROJECTNAME""$(printf "%05d" $tall)"_"$(date +%Y%m%d-%H%M%S)"
		$GPHOTO2 --set-config capture=on $CAMERAOPTS --force-overwrite --capture-image-and-download --hook-script=canon-dslr-hook-script

		echo "" # $SHOTNAME er det vi vil ha
	done
else
	echo Did not find a camera that is connected, turned on and ready for remote capture.
	exit 1
fi
