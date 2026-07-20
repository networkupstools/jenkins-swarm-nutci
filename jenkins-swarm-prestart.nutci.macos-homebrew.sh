#!/bin/sh

# Jenkins Swarm Client integration for NUT CI farm
# Copyright (C)
#   2021-2026 by Jim Klimov <jimklimov+nut@gmail.com>
# License: MIT

. ../jenkins-swarm/jenkins-swarm-prestart.nutci.macos-homebrew.include

#sed -e 's,^pidFile:.*$,,' -i.bak jenkins-swarm.yml
#cat >> jenkins-swarm.yml << EOF
#keepDisconnectedClients: false
#webSocket: false
#EOF

#[ -n "$TMPDIR" ] && [ -d "$TMPDIR" ] || TMPDIR="${SHMDIR}"
#[ -n "$TMPDIR" ] && [ -d "$TMPDIR" ] || TMPDIR=/tmp/jenkins-swarm

# Avoid ultra-long paths (probably inherited from launchd context) like
# /private/var/folders/7k/50lbl5md03s60b0nz5vx_3lw0000gn/T/jenkins-nutci/
# which overwhelm NUT CONFIG_FLAGS macro length en-masse :)
#TMPDIR=/tmp/jenkins-swarm

# NOTE: Even so, `/private` is prepended in practice:
TMPDIR=/tmp/shm
mkdir -p "$TMPDIR" || exit
export TMPDIR

# Needs sudoers-abuild-macos set up properly
# Recommended to comment away inheriting TMPDIR from caller above
# and just hard-code e.g. /tmp/jenkins-swarm here and in sudoers
# (for better security)
if ( [ -x /sbin/mount_tmpfs ] && command -v sudo) >/dev/null 2>/dev/null ; then
    if [ -n "`/sbin/mount | grep \"${TMPDIR}\"`" ] ; then : ; else
        # Can this can be automated in /etc/fstab equivalent?
        # -e : case-sensitive; -s X : size (RAM)
        sudo /sbin/mount_tmpfs -s 2G -e -o nodev,noatime,nosuid "${TMPDIR}" \
        && sudo /bin/chmod 1777 "${TMPDIR}" \
        || echo "FAILED to prepare tmpfs at ${TMPDIR}" >&2
    fi
fi

. ../jenkins-swarm/jenkins-swarm-prestart.nutci.linux-tmpfs.sh
