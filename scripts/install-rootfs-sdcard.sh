#!/bin/sh

echo "Formatting SD card, please wait..."
umount /dev/block/mmcblk1p1
make_ext4fs /dev/block/mmcblk1p1
mount /dev/block/mmcblk1p1 /external_sd
echo "done. Extracting rootfs..."
tar -C /external_sd/ -xzpvf /sdcard/ubuntu-mate_18.04_native_pplus_rootfs_unofficial.tar.gz
echo "done."

