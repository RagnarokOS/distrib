# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 1.14 2024/05/29 15:13:04 lecorbeau Exp $

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
PACKAGES	= policy-rcd-declarative-deny-all usrmerge ca-certificates \
		  oksh signify-openbsd less wget ed
