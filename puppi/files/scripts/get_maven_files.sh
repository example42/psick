#!/bin/bash
# get_maven_files.sh - Made for Puppi
# This script retrieves the files to deploy from a Maven repository.
# It uses variables defined in the general and project runtime configuration files.
# It uses curl to retrieve files so the $1 argument (base url of the maven repository) 
# has to be in curl friendly format

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

# Obtain the value of the variable with name passed as second argument
# If no one is given, we take all the files in storedir
if [ $2 ] ; then
    deployfilevar=$2
    deployfile="$(eval "echo \${$(echo ${deployfilevar})}")"
else
    deployfile="*"
fi


# Get the stuff
cd $storedir

curl $1/$version/$deployfile -O
if [ $? = "0" ] ; then
    exit 0 
else
    exit 2
fi


