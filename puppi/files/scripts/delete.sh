#!/bin/bash
# delete.sh - Made for Puppi
# This script moves is passed as $1 to a temp dir (volatile)

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

# Manage script variables
if [ $1 ] ; then
    tobedeleted=$1
else
    echo "You must provide a file or directory to delete!"
    exit 2 
fi

if [ "$tobedeleted" = "/" ] ; then
    echo "Be Serious!"
    exit 2
fi

# Move file
move () {
    mkdir /tmp/puppi/$project/deleted
    mv $tobedeleted /tmp/puppi/$project/deleted
}

move
