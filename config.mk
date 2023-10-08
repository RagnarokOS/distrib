# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 1.3 2023/10/08 18:44:09 lecorbeau Exp $

DISTRO		= ragnarok
PRETTY_NAME	= Ragnarok
VERSION		= 01
CODENAME	= -current
PUBLISHER	= Ian LeCorbeau
FLAVOUR		= bookworm
VARIANT		= minbase
COMPONENTS	= main non-free-firmware
HOOK_DIR	= hooks
SIGN_WITH	= signify
SEC_KEY		= 

# Packages included in everything.
PACKAGES	= base-passwd adduser usrmerge policy-rcd-declarative-deny-all libbsd0 libncurses-dev

# Packages included in the release tarball for base, provided they don't require
# special considerations. Otherwise, install them in hooks/release.
RELEASE_PKGS	= sysvinit-core sysv-rc elogind libpam-elogind orphan-sysvinit-scripts \
		  procps nftables bsd-mailx dma rsyslog logrotate openntpd ifupdown \
		  isc-dhcp-client wpasupplicant tmux vim linux-image-amd64
