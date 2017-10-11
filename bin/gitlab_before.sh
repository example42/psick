#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"
git_modules="psick puppet puppetserver graphanadash"

# r10k config file 
configfile=${1:-bin/config/gitlab-runner-r10k.yaml}
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
echo_title "Removing modules installed via git"
for i in `echo $git_modules`; do
  [ -d $i ] && rm -rf $i
done
echo_title "Installing external modules via r10k"
/opt/puppetlabs/puppet/bin/r10k puppetfile install -v ${config}
echo
