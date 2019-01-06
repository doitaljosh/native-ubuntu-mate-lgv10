#!/bin/bash

# Script for copying the Ubuntu files using adb

GITDIR='~/native-ubuntu-mate-v10'

if [[ $# -eq 0 ]] then
	echo "usage: ./copy_files.sh [internal | sdcard]"
	exit 1
else
	ROOTDEV=$1
fi

adb start-server
sleep 3

if [[ $1 -eq 'internal' ]] then
	echo "Copying files to external SD card for installation on internal storage..."
	adb push $GITDIR/boot-src/ubuntu-boot.img /external_sd/
	adb push $GITDIR/ubuntu-mate_18.04_native_pplus_rootfs_unofficial.tar.gz /external_sd/
	adb push $GITDIR/scripts /external_sd/
	echo "done."
elif [[ $1 -eq 'sdcard' ]] then
	echo "Copying files to internal storage for installation on SD card..."
	adb push $GITDIR/boot-src/ubuntu-boot.img /sdcard/
        adb push $GITDIR/ubuntu-mate_18.04_native_pplus_rootfs_unofficial.tar.gz /sdcard/
	adb push $GITDIR/scripts /sdcard/
	echo "done."
else
	echo "Invalid storage location, valid locations are: 'internal' or 'sdcard'."
fi
