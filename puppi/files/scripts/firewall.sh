#!/bin/bash
# firewall.sh - Made for Puppi
# This script places a temporary firewall (iptables) rule to block access from the IP defined as $1
# Use $2 to insert or remove the blocking rule (on|off) 
# Use this script to temporary remove your server from a load balancer pool during the deploy procedure

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
    ip=$1
else
    echo "You must provide at least an IP!"
    exit 2 
fi

if [ $2 ] ; then
    if [ $2 = "on" ] ; then
        action="-I"
    elif [ $2 = "off" ] ; then
        action="-D"
    else 
        echo "Your second argument must be on or off!"
        exit 2
    fi
else
    echo "You must provide 2 arguments"
    exit 2
fi

# Block
run_iptables () {
    iptables $action INPUT -s $ip -j DROP
}

run_iptables

# Sooner or later this script will have multiOS support
