#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
role=$1
image=$2

. "${repo_dir}/docker/config"
. "${repo_dir}/docker/env/${image}"

echo_title "## Building on image ${image} role ${role}"
puppet apply -t --basemodulepath "${repo_dir}/modules" --hiera_config "${repo_dir}/hiera.yaml" -e 'include ::docker::profile::rocker_builder'
