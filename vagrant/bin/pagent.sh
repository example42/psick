#!/bin/bash
options=$*

echo "## Running puppet agent ${options}"
puppet agent -t ${options} --detailed-exitcodes
result=$?
if [ "x$result" == "x0" ] || [ "x$result" == "x2" ]; then
  exit 0
else
  exit 1
fi
