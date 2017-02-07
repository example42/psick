#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"
set -o allexport
. /etc/gitlab-cli.conf
set +o allexport

source_branch=$1
destination_branch=$2
mr_title=${3:-"Puppet CI $*"}

set -x
gitlab create_merge_request $GITLAB_API_PROJECT_ID "$mr_title" "{ source_branch: $source_branch, target_branch: $destination_branch }"
