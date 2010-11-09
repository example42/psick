#!/bin/bash
# get_curl.sh - Made for Puppi
# This script retrieves via curl the files that have to be deployed
# The $1 argument (url of the file to retrieve) has to be in curl friendly format

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


cd $storedir
curl $1 -O
# Manage curl's exit codes
if [ $? = "0" ] ; then
    exit 0
else
    exit 2
fi
