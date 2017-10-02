#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

puppet_options="--modulepath ${repo_dir}/site:${repo_dir}/modules --environmentpath ${repo_dir}"

echo_title "Going to install awscli and dependencies"
puppet apply $puppet_options -e 'include psick::aws'

echo_title "Running aws configure"
aws configure

