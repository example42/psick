#!/bin/bash
# get_maven_files.sh - Made for Puppi
# This script retrieves the files to deploy from a Maven repository.
# It uses variables defined in the general and project runtime configuration files.
# It uses curl to retrieve files so the $1 argument (base url of the maven repository) 
# has to be in curl friendly format

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

# Obtain the value of the variable with name passed as second argument
# If no one is given, we take all the files in storedir

#echo "Download and deploy $2 ? (Y/n)" 
#read press
#case $press in 
#    Y|y) true ;;
#    N|n) save_runtime_config "predeploydir_$2=" ; exit 0
#esac

if [ $debug ] ; then
    tarcommand="tar -xvf"
else
    tarcommand="tar -xf"
fi

cd $storedir
case $2 in
    warfile)
        curl $1/$version/$warfile -O
        cp -a $warfile $predeploydir/$artifact.war
    ;;
    configfile)
        curl $1/$version/$configfile -O
        mkdir /tmp/puppi/$project/deploy_configfile
        cd /tmp/puppi/$project/deploy_configfile
        $tarcommand $storedir/$configfile
        save_runtime_config "predeploydir_configfile=/tmp/puppi/$project/deploy_configfile"
    ;;
    srcfile)
        curl $1/$version/$srcfile -O
        mkdir /tmp/puppi/$project/deploy_srcfile
        cd /tmp/puppi/$project/deploy_srcfile
        $tarcommand $storedir/$srcfile
        save_runtime_config "predeploydir_srcfile=/tmp/puppi/$project/deploy_srcfile"
    ;;
esac
