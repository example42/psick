#!/bin/bash

if [ "x$1" == "x" ]; then
  echo "Specify the name of the module you want to generate."
  read -p "Use author-module format, ie: example42-apache: " fullmodule
else
  fullmodule=$1
  template=${2:-https://github.com/puppetlabs/pdk-templates}
fi
# author=$(echo $fullmodule | cut -d '-' -f 1)
module=$(echo $fullmodule | cut -d '-' -f 2)

echo "Generating new module with pdk"
pdk new module $module --template-url=$template
