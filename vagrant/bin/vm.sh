#!/bin/bash
repo_dir="$(dirname $0)/../.."
. "${repo_dir}/bin/functions"
. "${repo_dir}/bin/config/proxysetup"
. "${repo_dir}/bin/config/defaults"

action=$1
vm=$2
env=${3-$vagrantenv}

export VAGRANT_DOTFILE_PATH=$HOME/.vagrant
mkdir -p $VAGRANT_DOTFILE_PATH

if [ "x${env}" != "" ]; then
  cd "${repo_dir}/vagrant/environments/${env}"
  vagrant $action $vm
else
  cd "${repo_dir}/vagrant/environments" 
  for v in $(ls); do
    echo_title "vagrant/environments/${v}"
    cd $v
    if [ -d ".vagrant/machines/${vm}" ]; then
      echo_subtitle "Running vagrant ${action} ${vm}"
      vagrant $action $vm
    else
      if [ $action == 'status' ]; then
        vagrant $action
      fi
      true
    fi
    cd ../
  done
fi

