# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 1.15 2024/06/30 15:52:09 lecorbeau Exp $

DISTRO		= ragnarok
PRETTY_NAME	= Ragnarok
VERSION		= 01
NAME		= ${DISTRO}${VERSION}
CODENAME	= Dyeus
PUBLISHER	= Ian LeCorbeau
FLAVOUR		= bookworm
VARIANT		= minbase
COMPONENTS	= main non-free-firmware

# Packages included in everything.
PACKAGES	= usrmerge ca-certificates oksh signify-openbsd \
		  less wget ed
