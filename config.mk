# General config file for releases
# $Ragnarok: config.mk,v 2.1 2024/11/06 17:59:17 lecorbeau Exp $

DISTRO		= ragnarok
PRETTY_NAME	= Ragnarok
VERSION		= -current
NAME		= ${DISTRO}${VERSION}
CODENAME	= current
PUBLISHER	= Ian LeCorbeau
FLAVOUR		= trixie
VARIANT		= minbase
COMPONENTS	= main non-free-firmware

# Packages included in everything.
PACKAGES	= usrmerge ca-certificates oksh signify-openbsd \
		  less wget ed
