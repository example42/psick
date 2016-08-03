#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
action=$1
vm=$2

cd "${repo_dir}/vagrant/environments"
for v in $(ls); do
  cd $v
  [ -d ".vagrant/machines/${vm}" ] && vagrant $action $vm || true
  cd ../
done

