#!/bin/bash
OLDSTRING=" "
NEWSTRING=" "
filter='vendor'
for file in $( grep -R "$OLDSTRING" . | grep -v ".git" | cut -d ":" -f 1 | grep -v 'massfindandreplace_macspurious.sh' | grep -v '$filter') ; do
    # Detect OS
    if [ -f /System/Library/Accessibility/AccessibilityDefinitions.plist ] ; then
      sed -i "" -e "s/$OLDSTRING/$NEWSTRING/g" $file && echo "Changed $file"
    else
      sed -i "s/$OLDSTRING/$NEWSTRING/g" $file && echo "Changed $file"
    fi
done

