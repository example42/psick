#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

echo_title "Main puppet-module repo"
cd $repo_dir
git status

for mod in $(ls -1 modules); do
  echo
  echo_title $mod 
  cd "${repo_dir}/modules/${mod}"
  git status
  git branch
  cd ../../
done
