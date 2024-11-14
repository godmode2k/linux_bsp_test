#!/bin/sh


# Create a bootable ISO file for GNU/Linux
#
# for grup-mkrescue
# sudo apt-get install grub-common
# sudo apt-get install xorriso


# ------------------------------------------
# ------------------------------------------
# ISO directory
# create a directory: ./new_iso/boot/grub
#
#
# // boot
# copy "grub.cfg" to ./new_iso/boot/grub
#
# // boot/grub/grub.cfg [
#set default=0
#set timeout=10
#menuentry 'new_OS' --class os {
#    insmod gzio
#    insmod part_msdos
#    linux /boot/bzImage
#    initrd /boot/initrd.cpio.gz
#}
# // boot/grub/grub.cfg ]
#
#
# // initrd image
# copy "initrd.cpio.gz" to ./new_iso/boot
#
#
# //Kernel image
# copy "bzImage" or "zImage", ... to ./new_iso/boot
#
#
# // Create a new ISO file
# $ grub-mkrescue -o new_os.iso <iso_path>
# or
# $ grub-mkrescue -o new_os.iso --dtb=<xxx.dtb> <iso_path>
#
# Default:
# grub-mkrescue -o new_os.iso ./new_iso/
# ARM 32bit:
# grub-mkrescue -o new_os.iso --dtb=./new_iso/boot/vexpress-v2p-ca9.dtb ./new_iso/



# ------------------------------------------
# ARM 32bit
# ------------------------------------------
# ISO directory
ISO_DIR="./iso_arm32bit"
mkdir -p $ISO_DIR/boot/grub

# grub.cfg
cat << EOF >> $ISO_DIR/boot/grub/grub.cfg
set default=0
set timeout=10

# Load EFI video drivers. This device is EFI so keep the
# video mode while booting the linux kernel.
#
#insmod efi_gop
#insmod font
#if loadfont /boot/grub/fonts/unicode.pf2
#then
#    insmod gfxterm
#    set gfxmode=auto
#    set gfxpayload=keep
#    terminal_output gfxterm
#fi

#menuentry 'new_OS' --class os {
#    insmod gzio
#    insmod part_msdos
#    linux /boot/bzImage
#    initrd /boot/initrd.cpio.gz
#}

menuentry 'arm32bit_OS' --class os {
    insmod gzio
    insmod part_msdos
    linux /boot/zImage
    initrd /boot/initrd.cpio.gz
}
EOF


# initrd
cp ../busybox-1.36.1/initrd.cpio.gz $ISO_DIR/boot


# Linux Kernel
cp ../linux-5.4.277/arch/arm/boot/zImage $ISO_DIR/boot
cp ../linux-5.4.277/arch/arm/boot/dts/vexpress-v2p-ca9.dtb $ISO_DIR/boot


# Create a new bootable ISO file
#grub-mkrescue -o new_os.iso $ISO_DIR
# ARM 32bit
echo "==> grub-mkrescue -o arm32bit_os.iso --dtb=$ISO_DIR/boot/vexpress-v2p-ca9.dtb $ISO_DIR"
echo
grub-mkrescue -o arm32bit_os.iso --dtb=$ISO_DIR/boot/vexpress-v2p-ca9.dtb $ISO_DIR


