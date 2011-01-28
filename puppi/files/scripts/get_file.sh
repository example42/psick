#!/bin/bash
# get_file.sh - Made for Puppi

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

# Show help
showhelp () {
    echo "This script is used to retrieve the file defined after the -s parameter"
    echo "The source specified  can be any of these:"
    echo "  file://local/file/path"
    echo "  http(s)://my.server/file/path"
    echo "  ssh://user@my.server/file/path"
    echo "  svn://user:password@my.server/file/path"
    echo "Note: Avoid using chars like : / and @ outside the Uri standards paths"
    echo
    echo "It has the following options:"
    echo "-s <source_file> - The URL of the file to get"
    echo "-t <file_type> - The type of file that is retrieved: list|tarball|maven-metadata|dir"
    echo "-d <local_dir> - An alternative destination directory (default is automatically chosen)"
}

while [ $# -gt 0 ]; do
  case "$1" in
    -s)
      type=$(echo $2 | cut -d':' -f1)
      url=$2
      downloadfilename=$(basename $2)
      downloaddir=$predeploydir
      shift 2 ;;
    -t)
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
          dir)
          downloaddir=$predeploydir
          save_runtime_config "dirfile=$downloaddir/$downloadfilename"
          save_runtime_config "metadatasource=dir"
      esac
      shift 2 ;;
    -d)
      # Enforces and overrides and alternative downloaddir
      downloaddir=$2
      shift 2 ;;
    *)
      showhelp
      exit
      ;;
  esac
done

# Define what to use for downloads
cd $downloaddir

case $type in 
    ssh|scp) 
        # ssh://user@my.server/file/path
        scpuri=$(echo $url | cut -d'/' -f3-)
        scpconn=$(echo $scpuri | cut -d'/' -f1)
        scppath=/$(echo $scpuri | cut -d'/' -f2-)
        rsync -rlptD -e ssh $scpconn:$scppath .
        if [ $? = "0" ] ; then
            save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
            exit 0
        else
            exit 2
        fi
    ;;
    http|https)
        curl -s -f $url -O
        # Manage curl's exit codes
        if [ $? = "0" ] ; then
            save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
            exit 0
        else
            exit 2
        fi
    ;;
    svn)
        svnuri=$(echo $url | cut -d'/' -f3-)
        svnusername=$(echo $svnuri | cut -d':' -f1)
        svnpassword=$(echo $svnuri | cut -d':' -f2 | cut -d'@' -f1)
        svnserver=$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f1)
        svnpath=/$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f2-)
        svn export --username=$svnusername --password=$svnpassword $svnserver $svnpath 
        if [ "$?" = "0" ] ; then
            save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
            exit 0
        else
            exit 2
        fi
    ;;
    file)
        # file:///file/path
        filesrc=$(echo $url | cut -d '/' -f3-)
        rsync -rlptD $filesrc .
        save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
    ;;
esac
