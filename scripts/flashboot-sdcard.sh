#!/bin/sh

echo "Backing up laf partition..."
dd if=/dev/block/bootdevice/by-name/laf of=/cache/lafbak.img
echo "done. Backup stored as /cache/lafbak.img"
echo "Flashing boot image..."
dd if=/dev/zero of=/dev/block/bootdevice/by-name/laf
dd if=/sdcard/ubuntu-boot.img of=/dev/block/bootdevice/by-name/laf
echo "done."
