#!/bin/bash -e

install -m 644 files/set_focus.service "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF
systemctl enable set_focus
apt-get remove -y libcamera0 python3-libcamera
mkdir -p "${ROOTFS_DIR}/opt/torquevision"
wget https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/libcamera-v0.0.5/libcamera-dev-0.0.12-bullseye-arm64.deb -O "${ROOTFS_DIR}/opt/torquevision/libcamera-dev-0.0.12-bullseye-arm64.deb"
wget https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/libcamera-apps-v0.0.5/libcamera-apps-0.0.12-bullseye-arm64.deb -O "${ROOTFS_DIR}/opt/torquevision/libcamera-apps-0.0.12-bullseye-arm64.deb"
set -e
dpkg -i "${ROOTFS_DIR}/opt/torquevision/libcamera-dev-0.0.12-bullseye-arm64.deb" || true
dpkg -i "${ROOTFS_DIR}/opt/torquevision/libcamera-apps-0.0.12-bullseye-arm64.deb" || true
apt-get -f install
wget -O install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
chmod +x install_pivariety_pkgs.sh
./install_pivariety_pkgs.sh -p imx519_kernel_driver
EOF

