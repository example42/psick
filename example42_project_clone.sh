#!/bin/bash
# This scripts changes references to example42 to your project string in Example42.com modules
# - Renames manifests and directories
# - Changes contents

echo "This script changes all the references of example42 to the string you define (your project)"
echo "Run it from the directory of the module you want to change"


echo "Enter the name of the original project (example42)"
read OLDPROJECT
echo "Enter the name of the new project"
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
	sed -i 's/$OLDPROJECT/$NEWPROJECT/g' $file && echo "Changed $file" # Use under Linux
	# sed -i "" -e 's/$OLDPROJECT/$NEWPROJECT/g' $file && echo "Changed $file" # Use under MacOS
done
