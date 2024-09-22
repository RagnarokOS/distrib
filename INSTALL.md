# Install Guide

This will guide you though a full Ragnarok install, using the official
installer, by showing the questions asked at install time and tips for
the answers.

*Note: this guide assumes the reader is a complete beginner.*

## Before the install

Boot from the latest [Ragnarok live ISO](https://ragnarokos.github.io/download.html).
Change to the root account and ensure that the repo is up to date.
(Tip: do it in tmux)

    $ tmux
    $ su
    # apt update && apt upgrade

*The password for root is 'root'*

## Further preparation

Next, decide whether you will create custom partitions or use the default
Ragnarok partitioning scheme which consists of a 500M /boot partition (Fat32
for efi systems, ext4 for bios/legacy systems), and separate swap, root and
home partitions whose size you will be asked to choose at install time.

Custom partitions can be created with whatever tool you prefer. Ragnarok's
ISO include fdisk/sfdisk/cfdisk by default, while parted is available in
the repository.

If you choose to create custom partitions, **ensure that they are mounted
to /mnt**. Also note that in this scenario, you will be tasked with setting
up the bootloader yourself.

Once you've decided, launch the installer:

    # ragnarok-install

## Disk Partitioning

Q: "Which disk should the system be installed on?"

Enter the device on which the system will be installed, e.g. /dev/sdX
(replace X with the proper letter).

Q: "The installer will create partitions on \<device\>. Warning all
data will be erased. Proceed (Y/n/s/?): "

'Y/y' will proceed with the rest of the disk configuration portion.
'N/n' will restart the process (e.g. if you entered the wrong device).
'S/s' will skip the rest of the disk configuration process. Choose this
option if you created a custom partitioning scheme.
'?' will show a help message.

If you chose 'S/s', you can move on to the next section.

Q: "Enter the boot mode for this system ('efi' or 'bios'): "

Self-explanatory. Note: Ragnarok uses grub for efi systems, and syslinux
(extlinux) for bios/legacy systems. This may help choosing if you can
actually decide the boot mode yourself (if your computer supports both,
or if installing the system in a virtual machine).

Q: "Choose the size of each partitions."

You will be asked to enter the size for the swap, root and home partitions
either in megabytes or gigabytes.

For size in megabytes, the format is **\<number\>M**, e.g. 500M.
For size in gigabytes, the format is **\<number\>G**, e.g. 30G.

If you want /home to use the rest of the available space, you can simply
press return without entering any size.

You will then be shown the partition table to be created and asked to proceed
or not. Answer 'Y' or 'y' to proceed, 'N' or 'n' to restart redo the device
partitioning part.

## Hostname / Timezone / Locale / Keyboard

Q: "Enter the hostname for this system: "

This cna be whatever you want. Spaces in the name are not allowed.

For the next three config settings, typing 'l' will open a list of available
options in `less`. 

Q: "Enter the timezone for this system. e.g. America/New_York. "

Set your timezone

Q: "Enter the locale for this system. e.g. en_US.UTF-8 UTF-8: "

Set the system's locale. It is important to not miss the charmap (e.g. UTF-8).

Q: "Set the keyboard layout. e.g. 'us': "

Set the keymap for both the console and X11.

## Select the sets

You will then be asked to select which extra set to install. These are
metapackages containing extra software and are entirely optional. 

The `devel` set contains git, build-essential and the full LLVM/Clang
toolchain from the project's own apt repo.

The `virt` set contains the bare minimum required to run virtual machines
directly with QEMU.

The `xserv` set contains a minimal xserver, xinit, xterm and alsa.

The `xfonts` set contains extra fronts for xorg (spleen, liberation, DejaVu).

The `xprogs` sets contain two window managers: OpenBSD's cwm, and Raven, a
fork of Suckless' dwm. It also contains rt (a fork of Suckless' st terminal),
dmenu, xcompmgr, xclip and hsetroot.

To install all the sets, simple leave empty and press Return. To install none
of the sets, type 'none' then Return. To pick and choose which set to install
simply type their name separated by a space.

If you chose to omit one or more set you can always install them later via
apt-get, e.g.

    apt-get install ragnarok-xserv ragnarok-xfonts

## Users and passwords

Q: "Password for the root account? "

This cannot be skipped. If you want to lock the root account, you can do it
after the install, though you should probably ensure to at least redirect
root's mail to the default user via /etc/aliases.

Q: "Setup a default user? [Y/n]: "

Choose if you want to create a default user. Typing 'n' will skip user
creation.

If you typed 'Y/y':

Q: "Name of the default user: "
Q: "Password for \<username\> "

Self-explanatory. Enter username and password.

## System installation

Grab a cup of coffee or a beer and let the installer do its thing.

When the installation process is done, you will be prompted to either type
'e' to exit the installer or 'r' to reboot. If you need extra non-free firmware,
you may type 'e' and use the `arch-chroot` command to install them, e.g.

    # arch-chroot /mnt apt-get install firmware-iwlwifi

would install non-free firmware for intel wifi cards.

## Afterboot

Once booted into the new system, don't forget to read root's mail and
the afterboot(8) manual.
