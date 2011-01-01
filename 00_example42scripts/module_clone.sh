#!/bin/bash

echo "This script creates a skeleton for a new module based on the"
echo "Example42 foo module template"
echo "Run it from the directory that contains the foo module (moduledir)"
echo

if [ ! -f foo/manifests/init.pp ] ; then
    echo "I don't find "foo/manifests/init.pp" , run this script from the base modules directory"
    exit 1
fi

OLDMODULE="foo"
echo
echo -n "Enter the name of the new module: "
read NEWMODULE

echo "COPYING MODULE"
cp -a $OLDMODULE $NEWMODULE


echo "RENAMING FILES"
for file in $( find $NEWMODULE | grep $OLDMODULE ) ; do 
	newfile=`echo $file | sed -e "s/$OLDMODULE/$NEWMODULE/"`
	mv "$file" "$newfile" && echo "Renamed $file to $newfile"
done

echo "---------------------------------------------------"
echo "CHANGING FILE CONTENTS"
for file in $( grep -R $OLDMODULE $NEWMODULE | cut -d ":" -f 1 | uniq ) ; do 
	sed -i "s/$OLDMODULE/$NEWMODULE/g" $file && echo "Changed $file" # Use under Linux
	# sed -i "" -e "s/$OLDMODULE/$NEWMODULE/g" $file && echo "Changed $file" # Use under MacOS
done

echo "Module $NEWMODULE created"
echo "Start to edit $NEWMODULE/manifests/params.pp to customize it"
