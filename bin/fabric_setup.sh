#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

puppet_options="--modulepath ${repo_dir}/site:${repo_dir}/modules:/etc/puppet/modules --environmentpath ${repo_dir}"

echo_title "Going to install Fabric"
echo_subtitle "Once installed run fab -l"
echo_subtitle "You need sudo powers. Executing: sudo -E puppet apply -e 'include psick::python::fabric'"

sudo -E puppet apply $puppet_options -e 'include psick ; include psick::python::fabric'

