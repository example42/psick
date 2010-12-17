#!/bin/bash
# service_extra.sh - Made for Puppi

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

# Show help
showhelp () {
    echo "This script is used to manage one or more services"
    echo "It requires AT LEAST 2 arguments:"
    echo "First argument (\$1 - required) is the script command (stop|start)"
    echo "Second argument and following (\$2 - required) is the space separated list of sevices to stop|start"
    echo 
    echo "Examples:"
    echo "service_extra.sh stop monit puppet"
}

# Check arguments
if [ $1 ] ; then
    servicecommand=$1
else
    showhelp
    exit 2
fi


if [ $# -ge 2 ] ; then
    shift 
    services=$@
else
    showhelp
    exit 2 
fi

# Manage service
service () {
    for serv in $services ; do
        /etc/init.d/$serv $servicecommand
    done
}

service
