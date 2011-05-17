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
      # In $predeploydir go ($workdir/$project/deploy) go file that have to be deployed
      # In $storedir go ($workdir/$project/store) go support files as tarballs or lists
          list)
          downloaddir=$storedir
          save_runtime_config "source_type=list"
          ;;
          tarball)
          downloaddir=$storedir
          save_runtime_config "source_type=tarball"
          ;;
          zip)
          downloaddir=$storedir
          save_runtime_config "source_type=zip"
          ;;
          maven-metadata)
          downloaddir=$storedir
          save_runtime_config "source_type=maven"
          ;;
          dir)
          downloaddir=$predeploydir
          save_runtime_config "source_type=dir"
          ;;
          war)
          downloaddir=$predeploydir
          save_runtime_config "source_type=war"
          ;;
          mysql)
          downloaddir=$storedir
          save_runtime_config "source_type=mysql"
          ;;

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
        check_retcode
        save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
    ;;
    http|https)
        curl -s -f $url -O
        check_retcode
        save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
    ;;
    svn)
        svnuri=$(echo $url | cut -d'/' -f3-)
        svnusername=$(echo $svnuri | cut -d':' -f1)
        svnpassword=$(echo $svnuri | cut -d':' -f2 | cut -d'@' -f1)
        svnserver=$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f1)
        svnpath=/$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f2-)
        mkdir -p $(dirname $svnpath)
        svn export --force --username="$svnusername" --password="$svnpassword" http://$svnserver/$svnpath $(dirname $svnpath)
        check_retcode
        save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
    ;;
    file)
        # file:///file/path
        filesrc=$(echo $url | cut -d '/' -f3-)
        rsync -rlptD $filesrc .
        check_retcode
        save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
    ;;
    rsync)
        rsync -rlptD $url .
        check_retcode
        save_runtime_config "downloadedfile=$downloaddir/$downloadfilename"
    ;;

esac
