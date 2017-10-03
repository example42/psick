#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
role=${1:-docker_sample_role}
image=${2:-'*'}    

dockerize() {
  r=$1
  i=${2:-'*'}

  . "${repo_dir}/docker/config"
  . "${repo_dir}/docker/env/${i}"

  export FACTER_role=$r
  echo_title "Building role ${r} on image ${i}"
  echo_subtitle "Running puppet apply on ::psick::docker::rocker_builder"
  puppet apply -t --basemodulepath "${repo_dir}/site::${repo_dir}/modules" \
               --environmentpath $repo_dir \
               -e "\$role = ${r} ; include psick" 
}

cd "${repo_dir}/docker"
for os in $(ls -1 env/$image | sed  's/env\///g'); do
  dockerize $role $os
done
