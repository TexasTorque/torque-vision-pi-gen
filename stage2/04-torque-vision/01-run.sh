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

wget https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/Arducam_pivariety_v4l2_v1.0/imx519_kernel_driver_5.15.84.tar.gz -O "${ROOTFS_DIR}/opt/torquevision/imx519_kernel_driver_5.15.84.tar.gz"
tar -zxvf "${ROOTFS_DIR}/opt/torquevision/imx519_kernel_driver_5.15.84.tar.gz" -C "${ROOTFS_DIR}/opt/torquevision/"
install -p -m 755 "${ROOTFS_DIR}/opt/torquevision/Release/arducam_camera_selector.sh" /usr/bin/
install -p -m 644 "${ROOTFS_DIR}/opt/torquevision/Release/bin/5.15.84-v8+/ak7375.ko.xz" "/lib/modules/5.15.84-v8+/kernel/drivers/media/i2c/"
install -p -m 644 "${ROOTFS_DIR}/opt/torquevision/Release/bin/5.15.84-v8+/imx519.ko.xz" "/lib/modules/5.15.84-v8+/kernel/drivers/media/i2c/"
install -p -m 644 "${ROOTFS_DIR}/opt/torquevision/Release/bin/5.15.84-v8+/imx519.dtbo" /boot/overlays/
/sbin/depmod -a 5.15.84-v8+
EOF

