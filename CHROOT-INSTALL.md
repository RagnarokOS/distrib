# Install Guide

Although Ragnarok has its official installer, it is possible perform a
'chroot-style' install using the base tarball. The following guide
assumes that you will be using a [live](https://github.com/RagnarokOS/distrib/releases)
Ragnarok ISO and that you know how to partition disks using command line tools
such as fdisk or cfdisk.

## Tip

Do yourself a favor and launch tmux. The base tarball being minimal, some
things will be missing which may cause errors with the terminal once chrooted
into the system. Doing the install in a tmux session will prevent them.

## Download base01.tgz

Before doing anything, fetch the latest base01.tgz tarball from the github
releases page:

    $ wget -q --show-progress -O base01.tgz https://github.com/RagnarokOS/distrib/releases/download/01/base01.tgz

## Switch to root

From then on, all commands need to be run as root. In a live Ragnarok system,
simply use the `su` command. The password is `root`.

## Preparing the disk

External tools such as fdisk or cfdisk can be used to create partitions.
Use whatever tool you want, but make sure that once the partitioning is done,
all partitions are mounted to `/mnt/`. If your system uses EFI, make sure that
the first partition is in fat32 format with at least 500mb of space.

When you're done creating the partitions, use mkfs to format the filesystems,
then mount the partitions to /mnt.

A recommended scheme for EFI systems is a 500mb /boot partition, a swap partition
at least equal in size to the system's available RAM, a 30-35Gb root partition and
a home partition utilizing the rest of the available space.

For legacy systems, the same scheme can be used, minus the boot partition.

Example mkfs/mount commands, assuming you have used the recommended partitioning
scheme (substitute *X* with the proper device letter):

EFI:  

    # mkfs.fat -F 32 /dev/sdX1
    # mkswap /dev/sdX2
    # mkfs.ext4 /dev/sdX3
    # mkfs.ext4 /dev/sdX4

    # mount -t ext4 -o errors=remount-ro /dev/sdX3 /mnt
    # swapon /dev/sdX2
    # mkdir -p /mnt/{boot/efi,home}
    # mount -t vfat -o umask=0077,noexec,nosuid,nodev /dev/sdX1 /mnt/boot/efi
    # mount -t ext4 -o defaults /dev/sdX4 /mnt/home

Legacy/Bios:  

    # mkswap /dev/sdX1
    # swapon /dev/sdX1
    # mkfs.ext4 /dev/sdX2
    # mkfs.ext4 /dev/sdX3

    # mount -t ext4 -o errors=remount-ro /dev/sdX2 /mnt
    # mkdir -p /mnt/home
    # mount -t ext4 -o defaults /dev/sdX3 /mnt/home

## Extract base01.tgz

Once you are certain all partitions are mounted to `/mnt/`, you can now untar
base01.tgz:

    # tar xzpvf base01.tgz --xattrs --xattrs-include='*' --numeric-owner -C /mnt

## Generate the fstab file

Use the `genfstab` command to generate a proper fstab file:

    # genfstab -U /mnt >> /mnt/etc/fstab

## Networking

Copy the system's /etc/resolv.conf to the chroot:

    # cp /etc/resolv.conf /mnt/etc/resolv.conf

Copy /etc/network/interfaces to the chroot for good measure:

    # mkdir -p /mnt/etc/network
    # cp /etc/network/interfaces /mnt/etc/network/

If you configured a wireless connection in /etc/network/interfaces.d/, you
can copy this directory to the chroot as well:

    # cp -r /etc/network/interfaces.d/ /mnt/etc/network/

## Set locale, timezone and keyboard

Before chrooting to the base system, use tools provided by the installer to
quickly set the locale, timezone and keyboard.

First, refresh the system's apt repos:

    # arch-chroot /mnt apt-get update

Then, use the `setlocale` utility to set the system's locale and charmap, e.g.:

    # setlocale en_US.UTF-8 UTF-8

See `/usr/share/ragnarok-installer/lists/locales.list` for a list of available
locales/charmaps. `setlocale` will also take care of setting up the console.

The `settz` utility can be used to set the timezone, e.g.

    # settz America/New_York

See `/usr/share/ragnarok-installer/tz.list` for a list of available timezones.

Finally, the setkb utility can be used to set the keyboard layout for both the
console and X11, e.g.

    # setkb us

See `/usr/share/ragnarok-installer/xkblayout.list` for a list of available keyboard
layouts.

## Chroot to the new system

Now, use the arch-chroot command to chroot into the system:

    # arch-chroot /mnt/ /bin/ksh

## Set hosts and hostname files

The `/etc/hosts` and `/etc/hostname` files use the `ragnarok` hostname
by default. Choose your own hostname if you want and change it using the
following sed command (subsituting *myhostname*):

    sed -i 's/ragnarok/myhostname/g' /etc/hosts /etc/hostname

## Install the kernel

Ragnarok has its own kernel built with LLVM/Clang, which takes advantage of Clang's
ThinLTO feature and bakes in many security options[1]. Although no bugs were found,
it has not been tested on enough hardware to guarantee that none will ever be found,
so users may install Debian's standard kernel as a backup if they wish.

*Note: Ragnarok's kernel does not support secure-boot out of the box. Furthermore,
hibernation is disabled as a security measure (however, suspend works as intended).*

Installing both kernels:

    # apt-get install linux-image-amd64 -y
    # apt-get install linux-image-ragnarok-amd64

Installing only the Ragnarok kernel:

    # apt-get install ragnarok-kernel

Differences between `linux-image-ragnarok-amd64` and `ragnarok-kernel`:

* `linux-image-ragnarok-amd64` only provides the kernel, its headers and libc-dev
packages.

* `ragnarok-kernel` installs `linux-image-ragnarok-amd64` plus all kernel dependencies
as well as all `dpkg` scripts normally provided by Debian's standard kernel (which are
not provided by other kernel packages but necessary to perform the preinst, postinst,
prerm and postrm tasks).

## Install extra sets (optional)

Aside from the base set, Ragnarok has extra sets (a.k.a metapackages) containing packages
that form the whole operating system.

These sets are optional, but highly recommended. Generally speaking, there should be a valid
reason to not install a certain set (IE: a server would obviously not need them). If you choose
to skip their installation here, you can always install them later on anyway.

The sets that can be installed:

devel:  the LLVM/Clang toolchain plus build-essential  
virt:   minimal package set to run QEMU virtual machines  
xserv:  minimal xserver and xinit  
xprogs: contains Window Managers (Raven and cwm) as well as the ragnarok-terminal (rt) and
        dmenu, xcompmgr, xclip and hsetroot.      
xfonts: contains some extra fonts (DejaVu, Liberation, Spleen)  
(more sets to come)

These sets are packaged under the `ragnarok-setname` name.

Example, installing all sets while keeping 'virt' as small as possible:

    # apt-get install ragnarok-devel ragnarok-xserv ragnarok-xprogs ragnarok-xfonts
    # apt-get install --no-install-recommends ragnarok-virt

## Install hardened_malloc

If desired, you can install GrapheneOS' hardened memory allocator.

    # apt-get install hardened-malloc

You can either enable the pre-compiled binary via init:

    # update-rc.d hardened_malloc defaults

or recompile the package using march=native and the variant of your choice
(light, medium or strong) if the `devel` set is installed:

    # cd /usr/src
    # tar xvf hardened_malloc.tgz
    # cd hardened_malloc
    # make VARIANT=light
    # cd
    # update-rc.d hardened_malloc defaults

Note that browsers (except Surf) tend to misbehave when hardened_malloc is enabled.

See: [https://github.com/RagnarokOS/hardened_malloc](https://github.com/RagnarokOS/hardened_malloc).

## Users and passwords

Set a password for the root user:

    # passwd

Create a new user and set password:

    # useradd -m -s /bin/ksh username
    # usermod -aG wheel,cdrom,floppy,audio,dip,video,plugdev,netdev username
    # passwd username

## Configure doas

Regular users part of the *wheel* group may be allowed to run commands as root by using doas
(a simpler replacement for sudo) by configuring the `/etc/doas.conf` file:

    # echo "permit :wheel" > /etc/doas.conf

See the doas(1) man page for more configuration options.

## Setup the bootloader

On EFI systems:


    # apt install grub-efi-amd64
    # grub-install --target=x86_64-efi --efi-directory=/boot/efi
    # update-grub

For bios/legacy systems:

    # apt-get install grub-pc
    # grub-install /dev/sdX     (where X is the device mount to /mnt)
    # update-grub

## Installing non-free firmware

If your system requires any non-free firmware package (e.g. for wireless cards), now would
be the time to install them.

Example for an intel wireless card:

    # apt-get install firmware-iwlwifi wpasupplicant

## Finalizing

Update the manual pages database:

    # makewhatis /usr/share/man

Clean up the chroot and exit:

    # apt clean
    # exit

Remove resolv.conf so it gets recreated at boot:

    # rm /mnt/etc/resolv.conf

If you liked some of the configuration files from the live ISO (e.g. tmux.conf, vimrc) you
can copy them to /mnt/home/*yourusername* before unmounting the devices (don't forget to check
the copied files' permissions).

Unmount the devices. Assuming the standard partitioning scheme was used:

    # umount /dev/sdX3
    # umount /dev/sdX2

You can now reboot to the newly installed system.

### Links

[1] - [https://ragnarokos.github.io/docs/kernel-security.html](https://ragnarokos.github.io/docs/kernel-security.html)

