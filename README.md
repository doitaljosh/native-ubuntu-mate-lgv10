# native-ubuntu-mate-lgv10

# Native Ubuntu MATE for LG V10

## Here's what's working:
### Screen:
- Display
- Touch
- Slimport HDMI (requires a little hacking around with FBIOPAN and slimport tx interrupt)
### Connectivity:
- Wi-Fi (all modes)
- Bluetooth (partial)
### Audio:
- HiFi headphone DAC (however s32_le (32-bit mode) uses a lot of CPU)
- Internal speaker
- 2 internal microphones
- Headset microphone
- All system sounds (USB/charger plug unplug, etc)
### Buttons:
- Volume/power buttons
### Other:
- Qualcomm quick charge

## To do:
- 3D GPU acceleration for Adreno 418 (freedreno)
- Write a native CMD mode panel driver for freedreno (LG4945 display)
- Get a working framebuffer console
- Enable screen rotation to landscape without losing vsync
- Venus video codec
- QRTR remoteproc driver backport for blobless modem
- Modem bringup
- Fix backlight sysfs location (led class -> backlight class)
- Adjust UI elements to fit around second screen notch
- Sensor bringup with IIO drivers
- Eliminate proprietary ADSP blobs for audio
- Backport brcmfmac wireless driver
- Mainline device-specific DT bindings
- Find method for serial UART debugging
- Eventually get mainline kernel running

## Bugs:
- Most DE's control the second screen backlight instead of the main backlight.
- Probably more

# How to install:
## Requirements:
- TWRP >= 3.0.0
- Unlocked bootloader
- 8GB or larger SD card
- 64-bit Linux computer or VM

## Prepare:
1. Make sure you have installed the following packages to your distribution:
   - `tar`
   - `git`
   - `android-tools-adb`
   - Development packages:
     - `apt install build-essential` for Debian
     - `pacman -S base-devel` for Arch
     - `yum group install "Development Tools"` for RPM
   - `linux-source`

2. Compile and install mkbootimg from [here](https://github.com/doitaljosh/android-unpackbootimg)
```   
git clone https://github.com/doitaljosh/android-unpackbootimg
cd ~/android-unpackbootimg
make -j4
sudo cp mkbootimg /usr/bin/
```

## IMPORTANT:
- If you are installing Ubuntu alongside Android, you must copy the installation files to the internal storage, but install Ubuntu to the SD card.
- If you are replacing Android with Ubuntu, then you must copy the installation files to the external SD card but install Ubuntu to the internal storage.

3. Clone this repository to your home folder then `cd` to the boot image build directory.
```
cd ~
git clone https://github.com/doitaljosh/native-ubuntu-mate-lgv10
cd native-ubuntu-mate-pplus/boot-src
```

## Build the boot image:
### Run the build script with these arguments to specify what partition Ubuntu will be installed on.
```
./mkbootimg-pplus.sh PARTITION
```
- Change `PARTITION` to one of the following:
  - `mmcblk1p1` for booting from the SD card.
  - `mmcblk0p53` for booting from data partition of internal storage.
### NOTE: Partitions MUST be formatted as ext4 for Ubuntu to be installed!
   - After running the script, a file called `ubuntu-boot.img` will be created in the `boot-src` directory.

## Copy the files to your LG V10
1. Turn off your device if it's on.
2. Boot your device into TWRP by holding down power/vol down then rapidly pressing power while still holding vol down when the LG logo appears.
3. When the **Factory Reset** screen appears, using your volume keys, navigate to **Yes** then press power to select.
4. Plug your phone into your computer making sure it's detected by Linux.
5. Run `adb devices` to make sure it's detected by ADB.
### NOTE: Copy the files to whichever memory you are NOT booting from whether it'd be either the SD card or the internal storage. I can't stress this enough.
6. Navigate to the root of the repository:
   - `cd ~/native-ubuntu-mate-lgv10`
7. Run the following script as instructed. 
- For booting Ubuntu from SD card, run:
```
./copy_files.sh sdcard
```
- For booting Ubuntu from internal storage, run:
```
./copy_files.sh internal
```
- Copying will take a few minutes as the files are around 1.8GB in size.

## Install the boot image
1. In TWRP, navigate to Advanced->Terminal from the main menu.
2. Carefully follow these instructions to wipe the partitions and install the boot image:
   - If you are booting Ubuntu from the SD card, run:
`/sdcard/scripts/flashboot-sdcard.sh`
   - If you are booting Ubuntu from the internal storage, run: 
`/external_sd/scripts/flashboot-internal.sh`

3. Now that the boot image is installed, it's time to extract the rootfs.
   - If you are booting Ubuntu from the SD card, run:
`/sdcard/scripts/install-rootfs-sdcard.sh`
   - If you are booting Ubuntu from the internal storage, run:
`/external_sd/scripts/install-rootfs-internal.sh`
### NOTE: The process will take around 15-20 minutes, as the rootfs consists of many files.

## Reboot into Ubuntu and enjoy:
1. If you installed Ubuntu to the SD card alongside Android, boot into Ubuntu by doing the following:
   - Power off the device completely.
   - Press and hold only the volume up button while plugging into a computer.
2. If you installed Ubuntu to the internal storage to replace Android, boot into Ubuntu by doing the following:
   - Power off the device and power on normally as you would with Android.

## The phone should boot right to the desktop.
