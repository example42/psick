#!/bin/bash
# This scripts clones an example42 project in a custom project:
# - Renames files
# - Changes contents
# - Leaves a basic infrastructure to work on

OLDPROJECT="example42"
NEWPROJECT="test42"
# NEWPROJECT="$1"

# renames files
echo "Renaming filenames: project_$OLDPROJECT -> project_$NEWPROJECT"
#find . | grep  project_$OLDPROJECT | awk '{print("mv "$1" "$1)}'  | sed 's/$OLDPROJECT/$NEWPROJECT/2' | /bin/bash

# Only dirs
# find . -type d  | grep  project_$OLDPROJECT | awk '{print("mv "$1" "$1)}'  | sed 's/$OLDPROJECT/$NEWPROJECT/2' | /bin/bash
cp -a project_$OLDPROJECT project_$NEWPROJECT

echo "Changin file contents: $OLDPROJECT -> $NEWPROJECT"
for a in $( grep -R $OLDPROJECT project_$NEWPROJECT | cut -d ":" -f 1 | uniq ) ; do 
	echo $a
	sed -i "s/$OLDPROJECT/$NEWPROJECT/g" $a 
done
