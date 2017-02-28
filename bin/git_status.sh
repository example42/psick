#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

echo_title "Showing git status of external modules"
cd $repo_dir
for mod in $(ls -1 modules); do
  cd "${repo_dir}/modules/${mod}"
  if [ -d '.git' ]; then
    echo
    echo_title "modules/${mod}"
    git status
    git branch
  fi
  cd ../../
done

echo_title "This Puppet control-repo"
git status

