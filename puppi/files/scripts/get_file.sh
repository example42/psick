#!/bin/bash
# get_file.sh - Made for Puppi

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
    echo "This script is used to retrive the file gives as \$1"
    echo "The source specified in \$1 can be any of these:"
    echo "  file://local/file/path"
    echo "  http(s)://my.server/file/path"
    echo "  ssh://user@my.server/file/path"
    echo "  svn://user:password@my.server/file/path"
    echo "Note: Avoid using chars like : / and @ outside the Uri standards paths"
    echo
    echo "It has 1 required and 1 optional argument:"
    echo "First argument (\$1 - required) is the path of the file to retrieve"
    echo "Second argument (\$2 - optional) if present and is \"list\" it considers the downloaded" 
    echo "  file as a list of files to be downloaded by other scripts"
}

if [ $1 ] ; then
    type=$(echo $1 | cut -d':' -f1)
    downloadfilename=$(basename $1)
    downloaddir=$storedir
else
    showhelp
    exit 2 
fi

if [ $2 = "list" ] ; then
    downloaddir=$workdir/$project
fi

# Define what to use for downloads
cd $downloaddir

case $type in 
    ssh|scp) 
        # ssh://user@my.server/file/path
        scpuri=$(echo $1 | cut -d'/' -f3-)
        scpconn=$(echo $scpuri | cut -d'/' -f1)
        scppath=/$(echo $scpuri | cut -d'/' -f2-)
        scp $scpconn:$scppath .
        if [ $? = "0" ] ; then
            save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
            exit 0
        else
            exit 2
        fi
    ;;
    http|https|file)
        curl $1 -O
        # Manage curl's exit codes
        if [ $? = "0" ] ; then
            save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
            exit 0
        else
            exit 2
        fi
    ;;
    svn)
        svnuri=$(echo $1 | cut -d'/' -f3-)
        svnusername=$(echo $svnuri | cut -d':' -f1)
        svnpassword=$(echo $svnuri | cut -d':' -f2 | cut -d'@' -f1)
        svnserver=$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f1)
        svnpath=/$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f2-)
        svn --export --username=$svnusername --password=$svnpassword $svnserver $svnpath 
        if [ $? = "0" ] ; then
            save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
            exit 0
        else
            exit 2
        fi
    ;;
esac
