# Linux BSP test (ARM)


Environment
----------
    OS: Ubuntu 20.04 x64 LTS
    VM: QEMU v7.2.11, v9.0.0 (https://www.qemu.org/)
    ARM Toolchain: arm-gnu-toolchain-13.x


ARM Toolchain
----------
```sh
download:
https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads

$ cd $HOME
$ mkdir arm-toolchain
$ cd arm-toolchain

1. AArch32
// arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-linux-gnueabihf
$ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz?rev=adb0c0238c934aeeaa12c09609c5e6fc&hash=B119DA50CEFE6EE8E0E98B4ADCA4C55F
$ tar xJvf arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz

2. AArch64
// arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-linux-gnu
$ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz?rev=22c39fc25e5541818967b4ff5a09ef3e&hash=B9FEDC2947EB21151985C2DC534ECCEC
$ tar xJvf arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz


// AArch32 bare-metal target (arm-none-eabi)
// for gdb (arm-none-eabi-gdb)
$ sudo apt-get install libncursesw5 libncursesw5-dev


// path
$ echo "export PATH=$PATH:/home/arm-toolchain/arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-linux-gnu/bin" >> $HOME/.profile
$ echo "export PATH=$PATH:/home/arm-toolchain/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-linux-gnueabihf/bin" >> $HOME/.profile
$ source $HOME/.profile




// Install ARM toolchain
https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads

// x86_64 Linux hosted cross toolchains
// AArch32 GNU/Linux target with hard float (arm-none-linux-gnueabihf)
// AArch64 GNU/Linux target (aarch64-none-linux-gnu)

or

$ sudo apt-get install gcc-aarch64-linux-gnu

// AArch32 bare-metal target (arm-none-eabi)
// for gdb (arm-none-eabi-gdb)
$ sudo apt-get install libncursesw5 libncursesw5-dev


// Build tools
$ sudo apt-get install build-essential bison flex libssl-dev swig python3-dev libgnutls28-dev
$ sudo apt-get install libncursesw5 libncursesw5-dev

// SEE: https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel
// Build Environment
//$ sudo apt-get install libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf llvm
```


QEMU Build Instructions
----------
```sh
$ cd $HOME

$ sudo apt-get update
$ sudo apt-get install build-essential gdb gdb-multiarch
$ sudo apt-get install python3 python3-pip ninja-build
$ sudo apt-get install pkg-config libglib2.0-dev
$ sudo apt-get install libslirp-dev
$ sudo apt-get install libpixman-1-dev
$ pip install sphinx
$ pip install sphinx_rtd_theme

// download QEMU 7.2.11, 9.0.0
$ wget https://download.qemu.org/qemu-7.2.11.tar.xz
$ wget https://download.qemu.org/qemu-9.0.0.tar.xz
$ tar xvJf qemu-7.2.11.tar.xz
$ tar xvJf qemu-9.0.0.tar.xz

$ cd qemu-7.2.11
// or
$ cd qemu-9.0.0


// ARM, AARCH64, x86_64
$ ./configure --target-list="arm-softmmu,arm-linux-user,aarch64-linux-user,aarch64-softmmu,x86_64-softmmu,x86_64-linux-user"
$ make

// with enable GTK
$ sudo apt-get install libgtk-3-dev
$ ./configure --target-list="arm-softmmu,arm-linux-user,aarch64-linux-user,aarch64-softmmu,x86_64-softmmu,x86_64-linux-user" --enable-gtk
$ make


// path
$ ln -s $HOME/qemu-7.2.11/build/qemu-arm .
$ ln -s $HOME/qemu-7.2.11/build/qemu-aarch64 .
$ ln -s $HOME/qemu-7.2.11/build/qemu-system-arm .
$ ln -s $HOME/qemu-7.2.11/build/qemu-system-aarch64 .
// or
$ ln -s $HOME/qemu-9.0.0/build/qemu-arm .
$ ln -s $HOME/qemu-9.0.0/build/qemu-aarch64 .
$ ln -s $HOME/qemu-9.0.0/build/qemu-system-arm .
$ ln -s $HOME/qemu-9.0.0/build/qemu-system-aarch64 .
```


u-boot
----------
```sh
$ wget https://github.com/u-boot/u-boot/archive/refs/tags/v2024.04.tar.gz -O u-boot-v2024.04.tar.gz
$ tar xzvf u-boot-v2024.04.tar.gz
$ cd u-boot-2024.04
$ make clean && make distclean

(arm)
$ make vexpress_ca9x4_defconfig ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
$ make -j4 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-


(aarch64)
//$ make vexpress_ca9x4_defconfig ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-
//$ make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-
//
$ export ARCH=arm64
$ export CROSS_COMPILE=aarch64-none-linux-gnu-
$ make vexpress_ca9x4_defconfig
$ make -j4


// or for qemu_defconfig
(arm)
$ make qemu_arm_defconfig ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
$ make -j4 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
(arm64)
$ export ARCH=arm64
$ export CROSS_COMPILE=aarch64-none-linux-gnu-
$ make qemu_arm64_defconfig
$ make -j4
```


Linux Kernel
----------
```sh
$ wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.277.tar.xz
$ tar xJvf linux-5.4.277.tar.xz
$ cd linux-5.4.277
$ make clean && make distclean

(x86_64)
$ make defconfig
$ make -j4


(arm)
//$ make versatile_defconfig ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
$ make vexpress_defconfig ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
$ make menuconfig ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
 // VersatilePB
 - Kernel Features -> Use the ARM EABI to compile the kernel
        -> Allow old ABI binaries to run with this kernel (EXPERIMENTAL)
 - System Type
        -> MMU-based Paged Memory Management Support
        -> Multiple platform selection -> ARMv5 based platforms (...)
        -> ARM Ltd. Versatile Express family --->
 // vexpress
 - Kernel Features -> Use the ARM EABI to compile the kernel
        //-> Allow old ABI binaries to run with this kernel (EXPERIMENTAL)
 - System Type
        -> MMU-based Paged Memory Management Support
        -> Multiple platform selection -> ARMv6 based platforms (...)
        -> Multiple platform selection -> ARMv7 based platforms (...)
        -> ARM Ltd. Versatile Express family --->
$ make -j4 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-


(aarch64)
////$ make versatile_defconfig ARCH=arm64
//$ make vexpress_defconfig ARCH=arm
//$ make menuconfig ARCH=arm64
//$ make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-
//
$ export ARCH=arm64
$ export CROSS_COMPILE=aarch64-none-linux-gnu-
//$ make defconfig
$ make vexpress_defconfig
$ make menuconfig
$ make -j4
```


RootFS (initrd): BusyBox
----------
```sh
(busybox)
$ wget https://www.busybox.net/downloads/busybox-1.36.1.tar.bz2
$ tar xjvf busybox-1.36.1.tar.bz2
$ cd busybox-1.36.1
$ make clean && make distclean


(arm)
$ make defconfig ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
$ make menuconfig ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf-
 - Settings
        -> Build Options -> Build static binary (no shared libs)
        -> Installation Options ("make install" behavior) -> (./_install) Destination path for 'make install'
$ make -j4 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- install

(aarch64)
//$ make defconfig ARCH=arm64
//$ make menuconfig ARCH=arm64
// - Busybox Setting -> Build Option -> Static binary
// - Settings
//        -> Installation Options ("make install" behavior) -> (./_install) Destination path for 'make install'
//$ make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- install
//
$ export ARCH=arm64
$ export CROSS_COMPILE=aarch64-none-linux-gnu-
$ make defconfig
$ make menuconfig
 - Busybox Setting -> Build Option -> Static binary
 - Settings
        -> Installation Options ("make install" behavior) -> (./_install) Destination path for 'make install'
$ make -j4 install


// output directory: _install
// initrd.cpio.gz or rootfs.img.gz
$ cd _install/

$ find . | cpio -H newc -o | gzip > ../initrd.cpio.gz
or
$ find . | cpio -H newc -ov --owner root:root > ../initrd.cpio && cd .. && gzip initrd.cpio
or
$ mkdir -p dev etc/init.d home/root lib mnt proc root sys tmp usr/lib var
$ echo -e '#!/bin/bash\nmount -t proc none /proc\nmount -t sysfs none /sys\n/sbin/mdev -s' > etc/init.d/rcS
$ chmod +x etc/init.d/rcS
//$ find . | cpio -o --format=newc > ../initrd.cpio && cd .. && gzip -c initrd.cpio > initrd.cpio.gz
$ find . | cpio -H newc -ov --owner root:root > ../initrd.cpio && cd .. && gzip initrd.cpio
or
$ mkdir proc sys dev run etc dev/pts etc/init.d
$ sudo mknod -m 666 dev/null c 1 3
$ sudo mknod -m 600 dev/console c 5 1
{
#!/bin/sh
#/etc/init.d/rcS
mount -v --bind /dev /dev
mount -v --bind /dev/pts /dev/pts
mount -vt proc proc /proc
mount -vt sysfs sysfs /sys
mount -vt tmpfs tmpfs /run
/sbin/mdev -s
}
echo -e '#!/bin/sh\n#/etc/init.d/rcS\nmount -v --bind /dev /dev\nmount -v --bind /dev/pts /dev/pts\nmount -vt proc proc /proc\nmount -vt sysfs sysfs /sys\nmount -vt tmpfs tmpfs /run\n/sbin/mdev -s' > etc/init.d/rcS
$ chmod +x etc/init.d/rcS
$ find . | cpio -H newc -ov --owner root:root -F ../initrd.64.cpio && cd .. && gzip initrd.64.cpio


// for SDcard (rootfs)
$ dd if=/dev/zero of=rootfs.img bs=1M count=100
$ mkfs.ext4 ./rootfs.img
$ mkdir /tmp/mnt_rootfs
//$ sudo mount -t ext4 -o loop ./rootfs.img /tmp/mnt_rootfs
$ sudo mount -t ext4 ./rootfs.img /tmp/mnt_rootfs
$ sudo cp -a -r _install/* /tmp/mnt_rootfs
$ sudo umount /tmp/mnt_rootfs

// Error: SDcard
qemu-system-arm: Invalid SD card size: 100 MiB
SD card size has to be a power of 2, e.g. 128 MiB.
$ dd if=/dev/zero of=rootfs.img bs=1M count=128
...
```


buildroot (ALL)
----------
```sh
$ wget https://www.buildroot.org/downloads/buildroot-2024.02.2.tar.xz
$ tar xJvf buildroot-2024.02.2.tar.xz
$ cd buildroot-2024.02.2
$ make clean && make distclean


//$ make list-defconfigs
$ make qemu_arm_vexpress_defconfig
$ make -j4
```


QEMU
----------
```sh
 - QEMU v9.0.0
 - USE QEMU v7.2.11

// boot ARM VersatilePB
//$ qemu-system-arm -M versatilepb -m 128M -kernel ./linux-5.4.277/arch/arm/boot/zImage -dtb ./linux-5.4.277/arch/arm/boot/dts/versatile-pb.dtb -initrd ./busybox-1.36.1/initrd.cpio.gz -append "root=/dev/ram rdinit=/bin/sh console=ttyAMA0,115200" -nographic
$ qemu-system-arm -M versatilepb -m 128M -kernel ./linux-5.4.277/arch/arm/boot/zImage -dtb ./linux-5.4.277/arch/arm/boot/dts/versatile-pb.dtb -initrd ./busybox-1.36.1/initrd.cpio.gz -append "root=/dev/ram rdinit=/sbin/init console=ttyAMA0,115200" -nographic


// boot ARM vexpress_ca9x4_defconfig
//$ qemu-system-arm -M vexpress-a9 -m 128M -kernel ./linux-5.4.277/arch/arm/boot/zImage -dtb ./linux-5.4.277/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd ./busybox-1.36.1/initrd.cpio.gz -append "root=/dev/ram rdinit=/bin/sh console=ttyAMA0,115200" -nographic
//$ qemu-system-arm -M vexpress-a9 -m 128M -kernel ./linux-5.4.277/arch/arm/boot/zImage -dtb ./linux-5.4.277/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd ./busybox-1.36.1/initrd.cpio.gz -append "root=/dev/ram rdinit=/sbin/init console=ttyAMA0,115200" -nographic
$ qemu-system-arm -M vexpress-a9 -m 128M -kernel ./linux-5.4.277/arch/arm/boot/zImage -dtb ./linux-5.4.277/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd ./busybox-1.36.1/initrd.cpio.gz -append "rdinit=/bin/sh console=ttyAMA0,115200" -nographic

// boot ARM vexpress_ca9x4_defconfig
// add SDcard
$ qemu-system-arm -M vexpress-a9 -m 128M -kernel ./linux-5.4.277/arch/arm/boot/zImage -dtb ./linux-5.4.277/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -sd ./rootfs.img -append "root=/dev/mmcblk0 rw rdinit=/bin/sh console=ttyAMA0,115200" -nographic


// boot Aarch64
$ qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a53 \
  -smp 1 \
  -m 128 \
  -nographic \
  -bios ./u-boot-2024.04/u-boot.bin \
  -kernel ./linux-5.4.277/arch/arm/boot/zImage \
//  -dtb ./linux-5.4.277/arch/arm/boot/dts/versatile-pb.dtb \
  -initrd ./busybox-1.36.1/initrd64.cpio.gz \
  -append "rdinit=/sbin/init console=ttyAMA0" \
  -device virtio-scsi-device

$ qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a57 \
  -smp 1 \
  -m 512 \
  -nographic \
  -kernel ./Image  \
  -initrd ./initrd64.cpio.gz   \
  -append "rdinit=/linuxrc console=ttyAMA0" \
  -device virtio-scsi-device


// or

$ sh run_qemu_with_new_kernel.sh
// quit QEMU: Ctrl+A, x
```


QEMU Issues
----------
```sh
1.
VFS: Cannot open root device "ram" or unknown-block(1,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
1f00          131072 mtdblock0
 (driver?)
1f01           32768 mtdblock1
 (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.277 #1
Hardware name: ARM-Versatile Express

==> -append "root=/dev/mmcblk0 rw rdinit=/bin/sh console=ttyAMA0,115200"


2.
Run /init as init process
Alignment trap: not handling instruction f8530b04 at [<0001225a>]
...
https://gitlab.com/qemu-project/qemu/-/issues/2326

==> USE QEMU 7.2.x
```


Create a bootable ISO file
----------
```sh
// for grup-mkrescue
$ sudo apt-get install grub-common
$ sudo apt-get install xorriso


$ git clone https://github.com/godmode2k/linux_bsp_test.git
$ cd linux_bsp_test/bootable_iso


(EDIT .sh environment first)

SEE:
 - init_add_files_arm32bit.sh
 - run_qemu_arm32bit_iso.sh


// initrd: busybox-1.36.1 (initrd.cpio.gz)
// Linux Kernel: linux-5.4.277 (arch/arm/boot/zImage, arch/arm/boot/dts/vexpress-v2p-ca9.dtb)


// creates ISO
$ sh init_add_files_arm32bit.sh

// run QEMU with new bootable ISO
$ sh run_qemu_arm32bit_iso.sh
```


