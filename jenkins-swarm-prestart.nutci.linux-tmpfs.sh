#!/bin/sh

# Jenkins Swarm Client integration for NUT CI farm
# Copyright (C)
#   2021-2022 by Jim Klimov <jimklimov+nut@gmail.com>
# License: MIT

# Intended to be symlinked as
#   .../jenkins-`hostname`/jenkins-swarm-prestart.sh
# and to run from that directory as current

set -e

SCRIPTDIR="`dirname "$0"`"
SCRIPTDIR="`cd "$SCRIPTDIR" && pwd`"

cd "$SCRIPTDIR"

mkdir -p "${HOME}/.ccache"
mkdir -p "${HOME}/.gitcache-dynamatrix"
mkdir -p "${HOME}/.gitcache-dynamatrix@tmp"

[ -n "$TMPDIR" ] && [ -d "$TMPDIR" ] || TMPDIR=/dev/shm
[ -n "$TMPDIR" ] && [ -d "$TMPDIR" ] || TMPDIR=/tmp
if [ -d "$TMPDIR" ] ; then
    #WSDIR="`mktemp -d "$TMPDIR/jenkins-nutci.XXXXXX"`"
    WSDIR="$TMPDIR/jenkins-nutci"
    mkdir -p "$WSDIR"
    rm -rf workspace
    ln -srf "$WSDIR" ./workspace 2>/dev/null \
    || ln -sf "$WSDIR" ./workspace
fi

if [ -d ./workspace/.gitcache-dynamatrix ] || [ -L ./workspace/.gitcache-dynamatrix ] || [ -h ./workspace/.gitcache-dynamatrix ] ;
then :
else
    rm -f ./workspace/.gitcache-dynamatrix
    ln -srf "${HOME}/.gitcache-dynamatrix" ./workspace/.gitcache-dynamatrix 2>/dev/null \
    || ln -sf "${HOME}/.gitcache-dynamatrix" ./workspace/.gitcache-dynamatrix
fi

if [ -d "./workspace/.gitcache-dynamatrix@tmp" ] || [ -L "./workspace/.gitcache-dynamatrix@tmp" ] || [ -h "./workspace/.gitcache-dynamatrix@tmp" ] ;
then :
else
    rm -f "./workspace/.gitcache-dynamatrix@tmp"
    ln -srf "${HOME}/.gitcache-dynamatrix@tmp" "./workspace/.gitcache-dynamatrix@tmp" 2>/dev/null \
    || ln -sf "${HOME}/.gitcache-dynamatrix@tmp" "./workspace/.gitcache-dynamatrix@tmp"
fi
