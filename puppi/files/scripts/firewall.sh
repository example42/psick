#!/bin/bash
# firewall.sh - Made for Puppi
# This script places a temporary firewall (iptables) rule to block access from the IP defined as $1
# Use $2 to define the port to block (Use 0 for all ports)
# Use $3 to insert or remove the blocking rule (on|off) 
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

if [ $3 ] ; then
    if [ $3 = "on" ] ; then
        action="-I"
    elif [ $3 = "off" ] ; then
        action="-D"
    else 
        echo "Your third argument must be on or off!"
        exit 2
    fi
else
    echo "You must provide 3 arguments"
    exit 2
fi

# Block
run_iptables () {
    if [ $2 = "0" ] ; then
        iptables $action INPUT -s $ip -j DROP
    else
        iptables $action INPUT -s $ip -p tcp --dport $2 -j DROP
    fi
}

run_iptables

# Sooner or later this script will have multiOS support
