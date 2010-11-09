#!/bin/bash
# recover.sh - Made for Puppi
# This script recovers to directory passed as $1 the data contained in the specified archive dir
# If $2 is given, that is used as a tagsubdir, where the archive is actually stored 

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
    documentroot=$1
else
    echo "You must provide a directory name!"
    exit 2 
fi

backuptag=""
if [ $2 ] ; then
    backuptag=$2
fi


if [ ! $rollbackversion ] ; then
    echo "Variable rollbackversion must exist!"
    exit 2 
fi
 

# Copy file
move () {
    if [ -d $archivedir/$project ] ; then
        cd $archivedir/$project
    else 
        echo "Can't find archivedir for this project"
        exit 2
    fi
    rsync -a $rollbackversion/$backuptag/* $documentroot
}

move
