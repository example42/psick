#!/bin/bash
# get_filesfromlist.sh - Made for Puppi

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
    echo "This script is used to retrieve the files present in a text file list."
    echo "It has 1 required argument:"
    echo "First argument (\$1 - required) is the base url (in URI format) from where to retrieve the files defined in the list"
    echo "The list file is defined as $downloadedfile , these variables are gathered from the Puppi runtime"
    echo "  config file."
    echo 
    echo "Examples: "
    echo "get_filesfromlist.sh http://svn.example42.com/myproject"
    echo "get_filesfromlist.sh file:///mount/wwwdata/myproject"
    echo "get_filesfromlist.sh ssh://user@server/var/www/myproject"
    echo "get_filesfromlist.sh svn://user:password@server/repo/myproject"
}


if [ $1 ] ; then
    baseurl=$1
    type=$(echo $1 | cut -d':' -f1)
else
    showhelp
    exit 2 
fi


deployfilelist=$downloadedfile

# Download files
downloadfiles () {

    cd $storedir

    for file in $(cat $deployfilelist | grep -v "^#" | grep -v "^$" ) ; do
        filepath=$file
        filedir=$(dirname $filepath)
        mkdir -p $filedir
        
        case $type in 
            ssh|scp) 
                scp $baseurl:$filepath $filepath
                if [ $? = "0" ] ; then
                    true
                else
                    exit 2
                fi
            ;;
            http|https|file)
                curl $baseurl/$filepath -o $filepath
                if [ $? = "0" ] ; then
                    true
                else
                    exit 2
                fi
            ;;
            svn)
                svnuri=$(echo $baseurl/$filepath | cut -d'/' -f3-)
                svnusername=$(echo $svnuri | cut -d':' -f1)
                svnpassword=$(echo $svnuri | cut -d':' -f2 | cut -d'@' -f1)
                svnserver=$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f1)
                svnpath=/$(echo $svnuri | cut -d'@' -f2 | cut -d'/' -f2-)
                svn --export --username=$svnusername --password=$svnpassword $svnserver $svnpath 
                if [ $? = "0" ] ; then
                    true
                else
                    exit 2
                fi
            ;;
        esac

    done
}

downloadfiles
