#!/bin/sh

echo "Backing up boot partition..."
dd if=/dev/block/bootdevice/by-name/boot of=/cache/bootbak.img
echo "done. Backup stored as /cache/bootbak.img"
echo "Flashing boot image..."
dd if=/dev/zero of=/dev/block/bootdevice/by-name/boot
dd if=/external_sd/ubuntu-boot.img of=/dev/block/bootdevice/by-name/boot
echo "done."
