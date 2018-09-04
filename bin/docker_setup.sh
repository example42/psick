#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

puppet_options="--modulepath ${repo_dir}/site:${repo_dir}/modules:/etc/puppet/modules --environmentpath ${repo_dir} --hiera_config ${repo_dir}/hiera.yaml"

echo_title "Going to install Docker"
echo_subtitle "You need sudo powers. Executing: sudo -E puppet apply -e 'include psick::docker'"
sudo -E puppet apply $puppet_options -e 'include psick ; include psick::docker'

