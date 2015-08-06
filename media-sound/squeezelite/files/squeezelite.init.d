#!/sbin/runscript
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

depend() {
    need net
    use alsasound
    after bootmisc
}

start() {
    ebegin "Starting squeezelite"
    start-stop-daemon \
	--start \
	--exec /usr/bin/squeezelite \
	--pidfile /var/run/squeezelite.pid \
	--make-pidfile \
	--user ${SL_USER} \
	--background \
	${SL_OPTS} ${SL_SERVERIP}
    eend $?
}

stop() {
    ebegin "Stopping squeezelite"
    start-stop-daemon \
	--stop \
	--exec /usr/bin/squeezelite \
	--pidfile /var/run/squeezelite.pid
  eend $?
}
