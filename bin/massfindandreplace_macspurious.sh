#!/bin/bash
OLDPROJECT=" "
NEWPROJECT=" "

for file in $( grep -R "$OLDPROJECT" . | grep -v ".git" | cut -d ":" -f 1 ) ; do
        sed -i "s/$OLDPROJECT/$NEWPROJECT/g" $file && echo "Changed $file" # Use under Linux
done
