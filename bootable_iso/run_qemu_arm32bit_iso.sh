#!/bin/sh


BASE_PATH=$HOME/qemu-7.2.11
QEMU_BIN=$BASE_PATH/qemu-system-arm
BIOS_PATH=$BASE_PATH/pc-bios
#BASE_PATH=$HOME/qemu-9.0.0
#QEMU_BIN=$BASE_PATH/qemu-system-arm
#BIOS_PATH=$BASE_PATH/pc-bios
ISO_PATH=./arm32bit_os.iso

# VNC port forwarding
# 10.0.2.16 (VirtualBox): run qemu-system-arm, tunneling (:55900 -> qemu-system-arm:vnc:127.0.0.1:5900)
#
# 192.168.x (host) -> 10.0.2.16:55900 (VirtualBox, port forward: :55900->10.0.2.16:55900)
#     -> 127.0.0.1:5900 (qemu-system-arm:vnc)
# (10.0.2.16) $ qemu-system-arm ...   # vnc default: 127.0.0.1:5900
# (10.0.2.16) $ ssh -v -L :55900:127.0.0.1:5900 -N -f 10.0.2.16
# (host, vnc client) connect to localhost:55900

#$QEMU_BIN -machine virt -cpu cortex-a57 -m 256M
#    -device virtio-blk-device,drive=hd \
#    -drive file=$ISO_PATH,if=none,id=hd \
#    -nographic \
#    -L $BIOS_PATH

$QEMU_BIN -M virt -m 256M \
    -drive file=$ISO_PATH,format=raw \
    -L $BIOS_PATH



#$QEMU_BIN \
#    -M vexpress-a9 \
#    -m 256M \
#    -device virtio-blk-device,drive=hd \
#    -drive file=$ISO_PATH,if=none,id=hd \
#    -nographic \
#    -L $BIOS_PATH
