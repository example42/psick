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
    echo "export suffix=$suffix" >> $workdir/$project/config
fi

# XML extraction
version=$(xml_parse release $storedir/maven-metadata.xml )
artifact=$(xml_parse artifactId $storedir/maven-metadata.xml )
warfile=$artifact-$version.war
if [ $suffix ] ; then
    srcfile=$artifact-$version-src-$suffix.tar
    configfile=$artifact-$version-cfg-$suffix.tar
else
    srcfile=$artifact-$version-src.tar
    configfile=$artifact-$version-cfg.tar
fi

# Store release version only if it's not already defined (to permit manual override)
grep "version" $workdir/$project/config || echo "export version=$version" >> $workdir/$project/config
# Store artifact id
echo "export artifact=$artifact" >> $workdir/$project/config
# Store filenames
echo "export warfile=$warfile" >> $workdir/$project/config
echo "export srcfile=$srcfile" >> $workdir/$project/config
echo "export configfile=$configfile" >> $workdir/$project/config

