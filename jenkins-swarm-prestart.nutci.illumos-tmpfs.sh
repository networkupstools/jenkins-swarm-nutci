#!/bin/sh

sed -e 's,^pidFile:.*$,,' -i jenkins-swarm.yml
cat >> jenkins-swarm.yml << EOF
keepDisconnectedClients: false
webSocket: false
EOF

# Need GNU ln for script below
PATH="/usr/gnu/bin:$PATH"
export PATH

TMPDIR=/tmp/jenkins-swarm
mkdir -p "$TMPDIR" || exit
export TMPDIR

#./jenkins-swarm-prestart.nutci.linux-tmpfs.sh
. ../jenkins-swarm/jenkins-swarm-prestart.nutci.linux-tmpfs.sh

