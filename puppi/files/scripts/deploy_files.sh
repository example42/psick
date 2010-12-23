#!/bin/bash
# deploy_file.sh - Made for Puppi

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

# Show help
showhelp () {
    echo "This script deploys one more files from the download dir (storedir) to the deployroot"
    echo "It has the following options:"
    echo "\$1 (Required) - Directory where to deploy files"
    echo "\$2 (Optional) - Name of the variable that identifies the specific file to deploy"
    echo 
    echo "Examples:"
    echo "deploy_file.sh /var/www/html/my_app"
    echo "deploy_file.sh /var/www/html/my_app/conf config"
}

# Check arguments
if [ $1 ] ; then
    deployroot=$1
else
    showhelp
    exit 2 
fi

# Obtain the value of the variable with name passed as second argument
# If no one is given, we take all the files in storedir
if [ $2 ] ; then
    deployfilevar=$2
    deployfile="$(eval "echo \${$(echo ${deployfilevar})}")"
else
    deployfile="*"
fi

# Copy file
deploy () {
    rsync -a $storedir/$deployfile $deployroot/
}

deploy
