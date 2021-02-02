#!/bin/sh
#
# TODO: Check for symlink attack.

APTLOG=$HOME/Documents/install-apt.log
SNAPLOG=$HOME/Documents/install-snap.log
LOGTMP=$(mktemp)

touch $APTLOG $SNAPLOG

sort -u $APTLOG > $LOGTMP
cat $HOME/.bash_history | grep "apt install" | grep -v grep | awk '{for(i=4;i<=NF;i++) printf $i; print ""}' | sort -bu >> $LOGTMP
sort -u $LOGTMP > $APTLOG

sort -u $SNAPLOG > $LOGTMP
snap list | grep -v Name | awk '{print $1}' >> $LOGTMP
sort -u $LOGTMP > $SNAPLOG
