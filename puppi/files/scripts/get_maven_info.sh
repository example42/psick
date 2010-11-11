#!/bin/bash
# get_maven_info.sh - Made for Puppi
# This script retrieves some info (release version, paths) from a maven-metadata.xml file
# The information gathered is then stored in the project runtime configuration file
# If passed as second argument, it stores also a Maven suffix variable

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


# Get the stuff
cd $storedir
curl $1/maven-metadata.xml -O
# Manage curl's exit codes
if [ $? != "0" ] ; then
    echo "Can't find $1/maven-metadata.xml"
    exit 2
fi

# Adds a Maven suffix, if passed as argument
if [ $2 ] ; then
    suffix=$2
    save_runtime_config "suffix=$suffix"
fi

# Store release version only if it's not already defined (to permit manual override)
if [ -z $version ] ; then
    version=$(xml_parse release $storedir/maven-metadata.xml )
    save_runtime_config "version=$version"
fi

artifact=$(xml_parse artifactId $storedir/maven-metadata.xml )
warfile=$artifact-$version.war
if [ $suffix ] ; then
    srcfile=$artifact-$version-src-$suffix.tar
    configfile=$artifact-$version-cfg-$suffix.tar
else
    srcfile=$artifact-$version-src.tar
    configfile=$artifact-$version-cfg.tar
fi

# Store artifact id
save_runtime_config "artifact=$artifact"
# Store filenames
save_runtime_config "warfile=$warfile"
save_runtime_config "srcfile=$srcfile" 
save_runtime_config "configfile=$configfile" 

