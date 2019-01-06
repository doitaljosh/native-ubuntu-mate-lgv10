#!/bin/sh

echo "Formatting data partition, please wait..."
umount /dev/block/mmcblk0p53
make_ext4fs /dev/block/mmcblk0p53
mount /dev/block/mmcblk0p53 /data
echo "done. Extracting rootfs..."
tar -C /data/ -xzpvf /sdcard/ubuntu-mate_18.04_native_pplus_rootfs_unofficial.tar.gz
echo "done."

