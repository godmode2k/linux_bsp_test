
Create a bootable ISO file for GNU/Linux


// for grup-mkrescue
$ sudo apt-get install grub-common
$ sudo apt-get install xorriso


USE an init script "__iso_template__/init_add_files.sh"
$ cp __iso_template__/init_add_files.sh <new_name.sh>
(EDIT)
$ vim <new_name.sh>
 
or follow the setup instructions below.



# ------------------------------------------
# ------------------------------------------
// Creates ISO directory
// create a directory: ./new_iso/boot/grub
$ mkdir -p ./new_iso/boot/grub


// boot
// copy "grub.cfg" to ./new_iso/boot/grub
$ cp grub.cfg ./new_iso/boot/grub


// boot/grub/grub.cfg [
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


menuentry 'new_OS' --class os {
    insmod gzio
    insmod part_msdos
    linux /boot/bzImage
    initrd /boot/initrd.cpio.gz
}
// boot/grub/grub.cfg ]


// initrd image
// copy "initrd.cpio.gz" to ./new_iso/boot
$ cp initrd.cpio.gz ./new_iso/boot


// Kernel image
// copy "bzImage" or "zImage", ... to ./new_iso/boot
$ cp bzImage ./new_iso/boot



// Create a new ISO file
$ grub-mkrescue -o new_os.iso <iso_path>
or
$ grub-mkrescue -o new_os.iso --dtb=<xxx.dtb> <iso_path>



