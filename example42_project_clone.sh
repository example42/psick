#!/bin/bash
# This scripts changes references to example42 to your project string in Example42.com modules
# - Renames manifests and directories
# - Changes contents

#OLDPROJECT="example42"
#NEWPROJECT="test42"
OLDPROJECT="$1"
NEWPROJECT="$2"

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
	sed -i "" -e 's/$OLDPROJECT/$NEWPROJECT/g' $file && echo "Changed $file"
done
