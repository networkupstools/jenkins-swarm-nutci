#!/bin/sh

. ../jenkins-swarm/jenkins-swarm-prestart.nutci.macos-homebrew.include

#sed -e 's,^pidFile:.*$,,' -i.bak jenkins-swarm.yml
#cat >> jenkins-swarm.yml << EOF
#keepDisconnectedClients: false
#webSocket: false
#EOF

TMPDIR=/tmp/jenkins-swarm
mkdir -p "$TMPDIR" || exit
export TMPDIR

. ../jenkins-swarm/jenkins-swarm-prestart.nutci.linux-tmpfs.sh
