#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

if [ -z $1 ]; then
  echo_subtitle "This script builds a docker image for a given OS"
  echo "Type the OS you want to use for the base image"
  ls -1 env/* | sed 's/env\///g'
  read os
  echo
else
  os=$1
fi

. config
. env/${os}
echo_title "# Building image for ${FACTER_operatingsystem} ${FACTER_operatingsystemmajrelease}"
puppet apply -t --basemodulepath "../modules" --hiera_config "hiera.yaml" -e 'include ::docker::profile::builder' 
