#!/bin/bash
# get_file.sh - Made for Puppi

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

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
    echo "Second argument (\$2 - optional) if present describes the kind of file to download"
    echo "  Currently can be 'list' , 'tarball' or 'maven-metadata' "
}

if [ $1 ] ; then
    type=$(echo $1 | cut -d':' -f1)
    downloadfilename=$(basename $1)
    downloaddir=$predeploydir
else
    showhelp
    exit 2 
fi

case $2 in
# This logic is applied:
# In $predeploydir go ($workdir/$project/deploy) go file that have to be deployed
# In $storedir go ($workdir/$project/store) go support files as tarballs or lists
    list)
    downloaddir=$storedir
    save_runtime_config "listfile=$downloaddir/$downloadfilename"
    save_runtime_config "metadatasource=list"
    ;;
    tarball)
    downloaddir=$storedir
    save_runtime_config "tarfile=$downloaddir/$downloadfilename"
    save_runtime_config "metadatasource=tarball"
    ;;
    maven-metadata)
    downloaddir=$storedir
    save_runtime_config "mavenfile=$downloaddir/$downloadfilename"
    save_runtime_config "metadatasource=maven"
    ;;
esac

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
        curl -f $1 -O
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
        if [ "$?" = "0" ] ; then
            save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
            exit 0
        else
            exit 2
        fi
    ;;
esac
