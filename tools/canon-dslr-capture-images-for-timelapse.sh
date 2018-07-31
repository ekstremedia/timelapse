#! /usr/bin/env bash

# stop virtual filesystem mounts that may prevent usb camera access
gvfs-mount -s gphoto2

GPHOTO2=gphoto2
CURL=curl

if ! type $GPHOTO2 >/dev/null 2>&1; then echo $GPHOTO2 not installed; exit 1; fi
if ! type $CURL >/dev/null 2>&1; then echo $CURL not installed; exit 1; fi

# for all supported config settings, run gphoto2 --list-all-config
DELAYBETWEENSHOTS=5
PROJECTNAME=timelap2-
CAMERAOPTS="--set-config autoexposuremode=M --set-config iso=100 --set-config exposurecompensation=0 --set-config aperture=2.8"

#FTPDEST="ftp://localhost/ut.jpg"			# comment out this to disable FTP
FTPUSERANDPASS="-u myftpusername:myftppassword"
FTPEVERYNTHFILE=5

# test if camera is online and reachable
$GPHOTO2 --summary >/dev/null
if [ "$?" = "0" ]
then
	let filecount=$FTPEVERYNTHFILE-1

	while true
	do
		/bin/date
		# SHOTNAME is used in the hook script
		export SHOTNAME="$PROJECTNAME-$(date +%Y%m%d-%H%M%S)"
		$GPHOTO2 --set-config capture=on $CAMERAOPTS --force-overwrite --capture-image-and-download --hook-script=canon-dslr-hook-script

		if [ -n "$FTPDEST" ]
		then
			let filecount=filecount+1
			if [ "$filecount" = "$FTPEVERYNTHFILE" ]
			then
				( echo Starting background upload of file to $FTPDEST && $CURL -s -T images/${SHOTNAME}.jpg $FTPUSERANDPASS $FTPDEST && echo FTP done ) &
				filecount=0
			fi
		fi

		echo Sleeping $DELAYBETWEENSHOTS seconds
		sleep $DELAYBETWEENSHOTS

		echo ""
	done
else
	echo Did not find a camera that is connected, turned on and ready for remote capture.
	exit 1
fi
