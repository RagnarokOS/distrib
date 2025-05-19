#!/bin/sh

# $Ragnarok: 0010_setup.sh,v 1.1 2025/05/19 17:39:35 lecorbeau Exp $
# Sync the repo first, then install eselect-repository and git. Any tasks
# to be done before switching Portage to git can be done here as well.

TARGET="$(./getval DESTDIR config.mk)/miniroot"

./chrootcmd "${TARGET}" "emerge-webrsync"

./chrootcmd "${TARGET}" "emerge -v app-eselect/eselect-repository dev-vcs/git"

