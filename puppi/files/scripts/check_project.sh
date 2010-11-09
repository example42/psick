#!/bin/bash
# check_project.sh - Made for Puppi
# This script runs the checks defined in $projectsdir/$project/check and then in $checksdir
# It can be used to automatically run tests during the deploy procedure

configfile="/etc/puppi/puppi.conf"

# Load general configurations
if [ ! -f $configfile ] ; then
    echo "Config file: $configfile not found"
    exit 1
else
    . $configfile
    . $scriptsdir/functions
fi

# Main functions
handle_check () {
        RETVAL=$?
        if [ "$RETVAL" = "1" ] ; then
            EXITWARN="1"
        fi
        if [ "$RETVAL" = "2" ] ; then
            EXITCRIT="1"
        fi

	# For nicer output when launched via cli
        echo -n "\n"
}

check () {
    for command in $(ls -v1 $projectsdir/$project/check) ; do
        "$projectsdir/$project/check/$command"
        handle_check
    done

    for command in $(ls -v1 $checksdir) ; do
        "$checksdir/$command" 
        handle_check
    done
}

# Run checks
check

# Manage general return code
if [ "$EXITCRIT" = "1" ] ; then
    exit 2
fi

if [ "$EXITWARN" = "1" ] ; then
    exit 1
fi
