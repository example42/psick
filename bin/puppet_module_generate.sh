#!/bin/bash

if [ "x$1" == "x" ]; then
  echo "Specify the name of the module you want to generate."
  read -p "Use this format: forge_username-module_name (ie: example42-apache): " fullmodule
else
  fullmodule=$1 
fi
# author=$(echo $fullmodule | cut -d '-' -f 1)
module=$(echo $fullmodule | cut -d '-' -f 2)
install_dir=$(puppet apply --configprint module_working_dir)
skeleton_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../skeleton"

if [ -d $install_dir ]; then
  echo "Moving current ${install_dir} to ${install_dir}.bak"
  mv $install_dir "${install_dir}.bak"
fi

echo "Copying module skeleton to ${install_dir}"
mkdir -p $install_dir
cd $skeleton_dir
cp -a * "${install_dir}/"
cp -a .* "${install_dir}/"
cd ../

echo "Generating ${module} module based on skeleton"
puppet module generate $fullmodule
mv "${module}/data/modulename" "${module}/data/${module}"
