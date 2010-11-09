#!/bin/bash
# archive.sh - Made for Puppi
# This script archives the content of the directory passed as $1 into the puppi archive dir
# If $2 is given, that is used as a tagsubdir, where the backup is actually stored 

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

if [ $1 ] ; then
    backuproot=$1
else
    echo "You must provide a directory name!"
    exit 2 
fi

backuptag=""
if [ $2 ] ; then
    backuptag=$2
fi

# Copy file
backup () {
    mkdir -p $archivedir/$project/$tag/$backuptag
    if [ $archivedir/$project/latest ] ; then
        rm -f $archivedir/$project/latest
    fi
    ln -sf $archivedir/$project/$tag $archivedir/$project/latest
    rsync -a $backuproot/* $archivedir/$project/$tag/$backuptag/
}

backup
