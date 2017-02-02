#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"

echo 
cd $repo_dir
echo_title "Installing external modules via r10k"
r10k puppetfile install -v
echo
