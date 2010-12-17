#!/bin/bash
# clean_filelist.sh - Made for Puppi

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

# Show help
showhelp () {
    echo "This script is used to cleanup a list of files to download from unwanted data"
    echo "It has 1 optional argument:"
    echo "The prefix, present in the list, to cut out when defining files to deploy"
    echo "The list file is defined as $downloadedfile , these variables are gathered from the Puppi runtime"
    echo "  config file."
    echo 
    echo "Example:"
    echo "clean_filelist.sh http://svn.example42.com/myproject"
}


if [ $1 ] ; then
    prefix=$1
else
    prefix=""
fi

deployfilelist=$downloadedfile

# Clean list
cleanlist () {

    sed -i "s/^$prefix//g" $deployfilelist

}

cleanlist
