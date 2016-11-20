#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
. "${script_dir}/functions"

host=$1
cat "${repo_dir}/bin/enc_cat/${host}.yaml"
