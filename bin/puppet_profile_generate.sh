#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"
app=${1:-undef}
repo=${2:-https://github.com/example42/pdk-module-template-tp-profile}

show_help () {
cat << EOF

This script wraps pdk (Puppet Development Kit) to create a new profile for a given application based on Tiny Puppet.
It requires the pdk command from Puppet Development Kit (https://docs.puppet.com/pdk/)
You must specify the name of the app for which to create a profile and an optional source git repo.

Usage:
$0 <app> [repo]
EOF
}

if [ "x${app}" == "xundef" ]; then
  show_help
fi

if [ ! -z $(which pdk) ]; then
  echo_title "Creating a new profile class with pdk"
  cd "${repo_dir}/site/profile"
  pdk new class --template-url=$repo "$app::tp"
else
  show_help
fi

