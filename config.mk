# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 2.1 2024/12/15 18:46:19 lecorbeau Exp $

DISTRO		= ragnarok
PRETTY_NAME	= Ragnarok
VERSION		= -current
NAME		= ${DISTRO}${VERSION}
CODENAME	= 
PUBLISHER	= Ian LeCorbeau
FLAVOUR		= trixie
VARIANT		= minbase
COMPONENTS	= main non-free-firmware

# Packages included in everything.
PACKAGES	= usrmerge ca-certificates oksh signify-openbsd \
		  less wget ed
