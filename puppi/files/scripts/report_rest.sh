#!/bin/bash
# report_rest.sh - Made for Puppi
# This script use REST for notifications

configfile="/etc/puppi/puppi.conf"

# Load general configurations
if [ ! -f $configfile ] ; then
    echo "Config file: $configfile not found"
    exit 1
else
    . $configfile
    . $scriptsdir/functions
fi

# Load project runtime configuration
projectconfigfile="$workdir/$project/config"
if [ ! -f $projectconfigfile ] ; then
    echo "Project runtime config file: $projectconfigfile not found"
    exit 1
else
    . $projectconfigfile
fi

. $scriptsdir/resty

$rest_protocol="http://"
$rest_server="127.0.0.1"
$rest_port="80"
get_rest_host () {
# TO DO
#resty $rest_protocol$rest_server:$rest_port/hosts*.xml
#a=$(GET /1)
}

get_rest_host



if [ "$EXITCRIT" = "1" ] ; then
    exit 2
fi

if [ "$EXITWARN" = "1" ] ; then
    exit 1
fi
