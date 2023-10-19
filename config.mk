# General config file for releases - Work In Progress
# $Ragnarok: config.mk,v 1.6 2023/10/19 17:51:04 lecorbeau Exp $

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
