#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.5 2025/05/19 17:15:30 lecorbeau Exp $
# Setup the repositories inside miniroot and base chroots.

TARGET="$(./getval DESTDIR config.mk)/miniroot"

# Disable the default to switch to git.
./chrootcmd "${TARGET}" "eselect repository disable gentoo"

# Re-enable. By default, eselect will choose git.
./chrootcmd "${TARGET}" "eselect repository enable gentoo"

# Delete the old repo.
/usr/bin/rm -rf "${TARGET}"/var/db/repos/gentoo

# Copy portage config to the chroot.
/usr/bin/rsync -Klrv portage.conf/ "${TARGET}/"

# Sync the repos separately.
./chroot "${TARGET}" "emaint sync -r gentoo"
./chroot "${TARGET}" "emaint sync -r ragnarok"
