#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

env=$1

echo_title "Deploying Puppet code on environment ${env}"
puppet code deploy $env --wait
