#!/bin/bash
# report_mail.sh - Made for Puppi
# This script sends a summary mail to the recipients defined in $1
# Use a comma separated list for multiple emails

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

# Check arguments
recipients=$1

# Main functions
mail_send () {
    result=$(grep result $logdir/$project/$tag/summary | awk '{ print $NF }')
    cat $logdir/$project/$tag/summary | mail -s "[puppi] $result $action of $project on $(hostname)" $recipients
}

mail_send

if [ "$EXITCRIT" = "1" ] ; then
    exit 2
fi

if [ "$EXITWARN" = "1" ] ; then
    exit 1
fi
