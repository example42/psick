#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"

# r10k config file 
configfile=$1
# Location of keys to copy into the local repository (removed from gilab_after.sh
eyamlkeyloc=$2

if [ -f "$eyamlkeyloc" ]; then
  echo "Setup keys"
  mkdir -p ${repo_dir}/keys
  cp -f ${eyamlkeyloc}/* ${repo_dir}/keys/
fi

if [ -f "$configfile" ]; then
  config="-c ${configfile}"
fi
echo 
cd $repo_dir
echo_title "Installing external modules via r10k"
/opt/puppetlabs/puppet/bin/r10k puppetfile install -v ${config}
echo
