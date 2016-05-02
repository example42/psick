#!/bin/bash
OLDSTRING=$1
NEWSTRING=$2

if [ ! $1 ] ; then
    echo "Usage: $0 oldstring newstring"
    exit 1
fi
for file in $( grep -R "$OLDSTRING" . | grep -v ".git" | cut -d ":" -f 1 ) ; do
        sed -i "s/$OLDSTRING/$NEWSTRING/g" $file && echo "Changed $file" # Use under Linux
done
