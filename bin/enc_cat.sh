#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
. "${script_dir}/functions"

host=$1
if [ -f "${repo_dir}/bin/enc_cat/${host}.yaml" ]; then
  cat "${repo_dir}/bin/enc_cat/${host}.yaml"
else
  cat "${repo_dir}/bin/enc_cat/default.yaml"
fi
