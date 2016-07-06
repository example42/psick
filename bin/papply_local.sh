#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

echo_title "Running bin/papply.sh --hiera_config=bin/hiera-local.yaml"
bin/papply.sh --hiera_config=bin/hiera-local.yaml $*
