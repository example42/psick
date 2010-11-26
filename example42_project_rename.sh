#!/bin/bash
# This scripts changes references to example42 to your project string in Example42.com modules
# - Renames manifests and directories
# - Changes contents

echo "This script changes all the references of example42 to the string you define (your project)"
echo "Run it from the directory of the module you want to change"

localsystem=$(uname)

if [ ! -f manifests/init.pp ] ; then
    echo "I don't find "manifests/init.pp" , run this script from inside a module directory"
    exit 1
fi

echo -n "Enter the name of the original project (example42): "
read OLDPROJECT

echo -n "Enter the name of the new project: "
read NEWPROJECT

echo "RENAMING MANIFESTS"
for file in $( find . -name $OLDPROJECT.pp ) ; do 
    newfile=`echo $file | sed -e "s/$OLDPROJECT/$NEWPROJECT/"`
    mv "$file" "$newfile" && echo "Renamed $file to $newfile"
done

echo "---------------------------------------------------"
echo "RENAMING DIRECTORIES"
for file in $( find . -type d | grep $OLDPROJECT ) ; do 
    newfile=`echo $file | sed -e "s/$OLDPROJECT/$NEWPROJECT/"`
    mv "$file" "$newfile" && echo "Renamed $file to $newfile"
done

echo "---------------------------------------------------"
echo "CHANGING FILE CONTENTS"
for file in $( grep -R $OLDPROJECT . | cut -d ":" -f 1 | uniq ) ; do 
    case $localsystem in
        Darwin)
            sed -i "" -e "s/$OLDPROJECT/$NEWPROJECT/g" $file && echo "Changed $file" # Use under MacOS
        ;;
        *)
        sed -i "s/$OLDPROJECT/$NEWPROJECT/g" $file && echo "Changed $file" # Use under Linux
        ;;
esac
done
