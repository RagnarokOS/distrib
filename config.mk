# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 1.9 2024/05/07 15:44:33 lecorbeau Exp $

DISTRO		= ragnarok
PRETTY_NAME	= Ragnarok
VERSION		= 01
CODENAME	= -current
PUBLISHER	= Ian LeCorbeau
FLAVOUR		= bookworm
VARIANT		= minbase
COMPONENTS	= main non-free-firmware

# Packages included in everything.
PACKAGES	= policy-rcd-declarative-deny-all usrmerge ca-certificates \
		  oksh signify-openbsd
