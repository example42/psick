#!/bin/bash

# Simple script to gather paths/configs info for different OS
# from WebMin modules' source 

# webmin_codepath="/usr/share/webmin"
webmin_codepath="/usr/libexec/webmin"


show_package () {
    basepath=$webmin_codepath/$package
    # webmin_codepath="/usr/share/webmin"
    for configline in $(cat $basepath/config.info | cut -d'=' -f1); do
        echo "-------------------------"
        echo $configline
        echo "-------------------------"
        for osfile in $(ls -1 $basepath/config-*); do
            os=$(basename $osfile | cut -d'-' -f2-) 
            output=$(grep $configline $osfile | cut -d'=' -f2) 
            echo "$os: $output"
        done
    done
}

show_os () {
    basepath=$webmin_codepath
    for module in $(ls -1 $basepath); do
        if [ ! -d $basepath/$module ] ; then
            echo # return
        fi
        echo "-------------------------"
        echo "$module - $os"
        echo "-------------------------"
        if [ ! -r $basepath/$module/config-$os ] ; then
#            return
            echo
        else
        cat $basepath/$module/config-$os
        fi 
    done
}


showhelp () {
   echo "Usage: $0 [-p package] [-o operatingsystem] "
   echo " "
   echo "Available options:"
   echo "-p - Specify package (module) to query"
   echo "-o - Specify Operating System to query"
}

# Check Input
if [ "$#" = "0" ] ; then
    showhelp
    exit
fi


while [ $# -gt 0 ]; do
  case "$1" in
    -p)
      package="$2"
      action="package"
      shift 2;;
    -o)
      os="$2"
      action="os"
      shift 2;;
    *)
      showhelp
      exit
      ;;
  esac
done

# Action!
case $action in 
    package) show_package ;;
    os) show_os ;;
esac

