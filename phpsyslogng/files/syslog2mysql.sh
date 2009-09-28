#!/bin/bash
###########################
# Name: syslog-ng_mysqld.sh
###########################
if [ -f /etc/sysconfig/syslog2mysqld ]; then
   . /etc/sysconfig/syslog2mysqld
fi


readonly PROGNAME=${0##*/}
readonly NAME_PID="/var/run/$PROGNAME.pid"
###########################
readonly NAME_COMMAND="/usr/bin/mysql -u$DBUSER -p$DBPWD $DBNAME"
readonly ERR_FAIL=1
readonly ERR_SUCCESS=0
##########################
[ $# -eq 1 ] && DBSYSLOG_PIPE="$1"
#
# Modified by EP - Tue Mar  6 14:58:02 CET 2007
# Pipe to /var/run from /tmp
: ${DBSYSLOG_PIPE:=/var/run/mysql.pipe}
##########################
# Main
##########################
[ ! -e "$DBSYSLOG_PIPE" ] && { echo "$PROGNAME: ERROR : $DBSYSLOG_PIPE not found" ; exit $ERR_FAIL ; }
while [ -e "$DBSYSLOG_PIPE" ]
do
        $NAME_COMMAND < $DBSYSLOG_PIPE
done

