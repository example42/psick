#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

puppet_options="--modulepath ${repo_dir}/site:${repo_dir}/modules:/etc/puppet/modules --environmentpath ${repo_dir} --hiera_config ${repo_dir}/bin/hiera5.yaml"

echo_title "Going to install Docker"
echo_subtitle "You will probably need superuser powers"
puppet apply $puppet_options -e 'include docker'

