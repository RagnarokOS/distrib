# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 2.8 2025/07/21 17:27:15 lecorbeau Exp $

# Location of the distrib repo. The default is '/usr/src/ragnarok/distrib'
# but can be set to anything else (eg. .local/src/distrib). This allows
# cloning the repo anywhere, and to create the tarballs anywhere as well.
SRCDIR		= /usr/src/ragnarok/distrib

# Ragnarok release version
VERSION		= 02

# The Gentoo tarball used as a base
TARBALL		= 

# Use portage with git instead of rsync? ('true' or 'fase').
PORTAGE_GIT	= true

# Should a toolchain tarball be fetched/extracted? 'true' or 'false'.
TOOLCHAIN	= true

# The top directory where the chroot will be created
DESTDIR		= ${SRCDIR}
MINIROOT	= ${DESTDIR}/miniroot
BASE		= ${DESTDIR}/base
