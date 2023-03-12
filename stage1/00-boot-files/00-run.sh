#!/bin/bash -e

install -m 644 files/cmdline.txt "${ROOTFS_DIR}/boot/"
install -m 644 files/config.txt "${ROOTFS_DIR}/boot/"
install -m 644 files/userconf.txt "${ROOTFS_DIR}/boot/"
# Commented out... CM4 users will probably need to grab this dt-blob. But if you're using a stock Pi, not required.
# wget https://datasheets.raspberrypi.org/cmio/dt-blob-cam1.bin -O "${ROOTFS_DIR}/boot/dt-blob.bin"
