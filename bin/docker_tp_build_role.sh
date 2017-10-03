#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
env_dir=$(dirname $repo_dir)
role=${1:-docker_tp_build}
image=${2:-'*'}    

dockerize() {
  r=${1}
  i=${2:-'*'}    

  . "${repo_dir}/docker/config"
  . "${repo_dir}/docker/env/${i}"

  export FACTER_role=$role
  
  echo_title "Building role ${r} on image ${i}"
  echo_subtitle "Running puppet using data in hieradata/role/${r}.yaml"
  puppet apply --test \
               --environment="${env_name}" \
               --environmentpath="${env_dir}" \
               --modulepath="${repo_dir}/modules:${repo_dir}/site" \
               --hiera_config "${repo_dir}/docker/hiera.yaml" \
               --execute "include psick"

}

cd "${repo_dir}/docker"
for os in $(ls -1 env/$image | sed  's/env\///g'); do
  dockerize $role $os
done
