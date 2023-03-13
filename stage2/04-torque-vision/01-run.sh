#!/bin/bash -e

install -m 644 files/set_focus.service "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF
systemctl enable set_focus
mkdir -p "${ROOTFS_DIR}/opt/torquevision"
wget https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/libcamera-v0.0.5/libcamera-dev-0.0.12-bullseye-arm64.deb -O "${ROOTFS_DIR}/opt/torquevision/libcamera-dev-0.0.12-bullseye-arm64.deb"
wget https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/libcamera-apps-v0.0.5/libcamera-apps-0.0.12-bullseye-arm64.deb -O "${ROOTFS_DIR}/opt/torquevision/libcamera-apps-0.0.12-bullseye-arm64.deb"
dpkg -i --force-overwrite "${ROOTFS_DIR}/opt/torquevision/libcamera-dev-0.0.12-bullseye-arm64.deb"
dpkg -i --force-overwrite "${ROOTFS_DIR}/opt/torquevision/libcamera-apps-0.0.12-bullseye-arm64.deb"
EOF

ln -sf "${ROOTFS_DIR}/usr/lib/aarch64-linux-gnu/libcamera.so.0.0.4" "${ROOTFS_DIR}/usr/lib/aarch64-linux-gnu/libcamera.so.0.0.3"
ln -sf "${ROOTFS_DIR}/usr/lib/aarch64-linux-gnu/libcamera-base.so.0.0.4" "${ROOTFS_DIR}/usr/lib/aarch64-linux-gnu/libcamera-base.so.0.0.3"
