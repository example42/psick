#!/bin/bash
# service.sh - Made for Puppi
# This script is a very basic generic wrapper to restart/reload services after a deploy
# It just runs $1 followed by $2 (!)

configfile="/etc/puppi/puppi.conf"

# Load general configurations
if [ ! -f $configfile ] ; then
    echo "Config file: $configfile not found"
    exit 2
else
    . $configfile
    . $scriptsdir/functions
fi

# Load project runtime configuration
projectconfigfile="$workdir/$project/config"
if [ ! -f $projectconfigfile ] ; then
    echo "Project runtime config file: $projectconfigfile not found"
    exit 2
else
    . $projectconfigfile
fi

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
