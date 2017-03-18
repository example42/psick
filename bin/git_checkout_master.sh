#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

cd $repo_dir
for mod in $(ls -1 modules); do
  cd "${repo_dir}/modules/${mod}"
  if [ -d '.git' ]; then
    echo
    echo_title "modules/${mod}"
    git checkout master
  fi
  cd ../../
done

