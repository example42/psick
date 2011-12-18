#!/bin/bash

echo "This script makes a clone of the example43 module, with the name you provide"
echo "The result module can you used to place you custom files and classes related to you own \$my_project"

localsystem=$(uname)

if [ ! -f example43/manifests/init.pp ] ; then
    echo "I don't find "example43/manifests/init.pp" , run 00_example42scripts/example43_project_clone.sh for the main Example42 modules directory"
    exit 1
fi


OLDMODULE="example43"
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
	# sed -i "" -e "s/$OLDMODULE/$NEWMODULE/g" $file && echo "Changed $file" # Use under MacOS
done

echo "Project Module $NEWMODULE created"
echo "Give a look to $NEWMODULE/README and customize it"
