# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 2.3 2025/05/07 17:15:38 lecorbeau Exp $

# Ragnarok release version
VERSION		= 02

# The Gentoo tarball used as a base
TARBALL		= 

# The top directory where the chroot will be created
DESTDIR		= /usr/src/ragnarok

# Location of the source repo. Default: /usr/src/ragnarok/src
SRCDIR		= /usr/src/ragnarok/src

# All files in directories listed here will be copied to the chroot as
# soon as it is unpacked.
INCLUDES	= ${SRCDIR}/etc/portage ${SRCDIR}/var/lib/portage
