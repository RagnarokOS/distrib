# Config file for iso - Work In Progress

DISTRO		= ragnarok
PRETTY_NAME	= Ragnarok
VERSION		= 01
CODENAME	= dev
PUBLISHER	= Ian LeCorbeau
FLAVOUR		= bookworm
ISOMODE		= live
VARIANT		= minbase
COMPONENTS	= main contrib non-free non-free-firmware
HOOK_DIR	= /usr/share/mkiso/hooks

BOOTPARAMS	= boot=live live-config.hooks=filesystem live-config.locales=en_CA.UTF-8 live-config.timezone=Canada/Eastern live-config.hostname=ragnarok live-config.noautologin live-config.sysv-rc=opensmtpd slab_nomerge init_on_alloc=1 init_on_free=1 page_alloc.shuffle=1 pti=on randomize_kstack_offset=on vsyscall=none debugfs=off lockdown=confidentiality

PACKAGES	= base-passwd adduser ragnarok-files signify-openbsd oksh hardened-malloc policy-rcd-declarative-deny-all libncurses6 libncursesw6
