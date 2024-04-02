# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 1.8 2024/04/02 14:52:36 lecorbeau Exp $

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
PACKAGES	= usrmerge ca-certificates

# Packages in base
BASE_PACKAGES	= ${PACKAGES} ragnarok-base
