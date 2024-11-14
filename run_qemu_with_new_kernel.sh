#!/bin/sh



BASE_PATH=$HOME/qemu-7.2.11
QEMU_BIN=$BASE_PATH/qemu-system-arm
QEMU_BIN_AARCH64=$BASE_PATH/qemu-system-aarch64


# ---------------------------------
# arm (versatilepb)
# ---------------------------------
#    -append "root=/dev/ram rdinit=/bin/sh console=ttyAMA0,115200" \
#    -append "root=/dev/ram rdinit=/sbin/init console=ttyAMA0,115200" \
#
<<COMMENT
#$QEMU_BIN \
#    -M versatilepb \
#    -m 128M \
#    -kernel ./linux-5.4.277/arch/arm/boot/zImage \
#    -dtb ./linux-5.4.277/arch/arm/boot/dts/versatile-pb.dtb \
#    -initrd ./busybox-1.36.1/initrd.cpio.gz \
#    -append "root=/dev/ram rdinit=/sbin/init console=ttyAMA0,115200" \
#    -nographic
COMMENT



# ---------------------------------
# arm (vexpress_ca9x4_defconfig)
# ---------------------------------
#    -append "root=/dev/ram rdinit=/bin/sh console=ttyAMA0,115200" \
#    -append "root=/dev/ram rdinit=/sbin/init console=ttyAMA0,115200" \
#    -append "rdinit=/bin/sh console=ttyAMA0,115200" \
#    -append "rdinit=/linuxrc console=ttyAMA0,115200" \
#
<<COMMENT
$QEMU_BIN \
    -M vexpress-a9 \
    -m 128M \
    -kernel ./linux-5.4.277/arch/arm/boot/zImage \
    -dtb ./linux-5.4.277/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
    -initrd ./busybox-1.36.1/initrd.cpio.gz \
    -append "rdinit=/bin/sh console=ttyAMA0,115200" \
    -nographic
COMMENT


# ---------------------------------
# arm (vexpress_ca9x4_defconfig)
# add SDcard
# ---------------------------------
#    -sd ./busybox-1.36.1/rootfs.img \
#    -drive file=./busybox-1.36.1/rootfs.img,format=raw,if=sd \
#
#    -append "root=/dev/mmcblk0 rw console=ttyAMA0,115200" \
#    -append "root=/dev/mmcblk0 rw rdinit=/bin/sh console=ttyAMA0,115200" \
#    -append "root=/dev/mmcblk0 rw rdinit=/sbin/init console=ttyAMA0,115200" \
#    -append "root=/dev/mmcblk0 rw rdinit=/linuxrc console=ttyAMA0,115200" \
#<<COMMENT
$QEMU_BIN \
    -M vexpress-a9 \
    -m 256M \
    -kernel ./linux-5.4.277/arch/arm/boot/zImage \
    -dtb ./linux-5.4.277/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
    -sd ./busybox-1.36.1/rootfs.img \
    -append "root=/dev/mmcblk0 rw /bin/sh console=ttyAMA0,115200" \
    -nographic
#COMMENT



# ---------------------------------
# aarch64
# ---------------------------------
#    -cpu cortex-a53 \
#    -append "rdinit=/linuxrc console=ttyAMA0,115200" \
#
<<COMMENT
#$QEMU_BIN_AARCH64 \
#    -M virt \
#    -cpu cortex-a57 \
#    -m 128M \
#    -kernel ./linux-5.4.277/arch/arm64/boot/zImage \
#    -dtb ./linux-5.4.277/arch/arm64/boot/dts/versatile-pb.dtb \
#    -initrd ./busybox-1.36.1/initrd64.cpio.gz \
#    -append "rdinit=/sbin/init console=ttyAMA0,115200" \
#    -device virtio-scsi-device \
#    -nographic
COMMENT


