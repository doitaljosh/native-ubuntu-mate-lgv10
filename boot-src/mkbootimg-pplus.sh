#!/bin/bash

# mkbootimg-pplus.sh

# Build the boot image file for LG V10 smartphones.

if [ $# -eq 0 ]; then
	echo "usage: ./mkbootimg-pplus.sh [PARTITION]"
	exit 1
fi

KIMAGE='vmlinuz-3.10.84'
INITRD='initrd.img-3.10.84'
PARTITION=$1
CMDLINE='console=tty1 root=/dev/'$PARTITION' rootwait rw rootfstype=ext4 user_debug=31 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 msm_rtb.filter=0x37'
BASE='0xffff8000'
PAGESIZE='4096'
DTBFILE='dtb.img'
KOFFSET='0x00008000'
RDOFFSET='0x02208000'
OUTFILE='out/ubuntu-boot.img'

echo "Building boot image"
/usr/bin/mkbootimg --kernel $KIMAGE --ramdisk $INITRD --cmdline $CMDLINE --base $BASE \
--pagesize $PAGESIZE --dt $DTBFILE --kernel_offset $KOFFSET --ramdisk_offset $RDOFFSET \
-o $OUTFILE
sleep 1
if [ -e ./ubuntu-boot.img ] then
	echo "done."
else
	echo "Unknown error, please try again."
fi

