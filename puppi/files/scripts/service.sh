#!/bin/bash
# service.sh - Made for Puppi
# This script is a very basic generic wrapper to restart/reload services after a deploy
# It just runs $1 followed by $2 (!)

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

# Check arguments
if [ $1 ] ; then
    servicescript=$1
else
    echo "You must provide at least a service script name!"
    exit 2
fi

if [ $2 ] ; then
    servicecommand=$2
else
    servicecommand="restart"
fi

# Manage service
service () {
    $servicescript $servicecommand
}

service

