#!/bin/bash
# archive.sh - Made for Puppi

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

# Show help
showhelp () {
    echo "This script is used to backup or restore contents to/from puppi archivedir"
    echo "It has the following options:"
    echo "-b <backup_source> - Backups the files to be changed in the defined directory"
    echo "-r <recovery_destination> - Recovers file to the provided destination"
    echo "-c <none|zip|tar|tar.gz> - Specifies the compression method to use"
    echo "-s <copy|move> - Specifies the backup strategy (move or copy files)"
    echo "-t <tag> - Specifies a tag to be used for the backup"
    echo "-d <variable> - Specifies the runtime variable that defines the predeploy dir"
    echo 
    echo "Examples:"
    echo "archive.sh -b /var/www/html/my_app -t html -c zip"
}

# Arguments check
if [ "$#" = "0" ] ; then
    showhelp
    exit
fi

compression=none
backuptag=all
strategy=copy

while [ $# -gt 0 ]; do
  case "$1" in
    -b)
      backuproot=$2
      action=backup
      shift 2 ;;
    -r)
      backuproot=$2
      action=recovery
      shift 2 ;;
    -t)
      backuptag=$2
      shift 2 ;;
    -s)
      case "$2" in
        mv) strategy="move" ;;
        move) strategy="move" ;;
        *) strategy="copy" ;;
      esac
      shift 2 ;;
    -c)
      case "$2" in
        zip) compression="zip" ;;
        tar.gz) compression="tar.gz" ;;
        tar) compression="tar" ;;
        *) compression="none" ;;
      esac
      shift 2  ;;
    -d)
      predeploydir="$(eval "echo \${$(echo $2)}")"
      shift 2 ;;
    -o) 
      rsyncoptions=$2
      shift 2 ;;
    *)
      showhelp
      exit
      ;;
  esac
done


# Backup and Restore functions
backup () {
    mkdir -p $archivedir/$project/$tag/$backuptag
    if [ $archivedir/$project/latest ] ; then
        rm -f $archivedir/$project/latest
    fi
    ln -sf $archivedir/$project/$tag $archivedir/$project/latest

    if [ "$strategy" = "move" ] ; then 
        command="mv"
    else
        command="rsync -a $rsyncoptions"
    fi

    for file in $(ls -v1 $predeploydir) ; do
        $command $backuproot/$file $archivedir/$project/$tag/$backuptag/
    done

}

recovery () {
    if [ ! $rollbackversion ] ; then
        echo "Variable rollbackversion must exist!"
        exit 2 
    fi

    if [ -d $archivedir/$project ] ; then
        cd $archivedir/$project
    else 
        echo "Can't find archivedir for this project"
        exit 2
    fi
    rsync -a $rsyncoptions $rollbackversion/$backuptag/* $backuproot
}

# Action!
case "$action" in
    backup) backup ;;
    recovery) recovery ;;
esac
