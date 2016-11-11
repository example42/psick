#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

if [ "$1" = "auto" ]; then
  auto=true
fi

echo_title "Removing Docker images"
[ "$auto" = "true" ] || ask_warning "Are you sure you want to remove all local docker images?"
[ "$?" = 0 ] || exit 1
docker rmi $(docker images -q)

echo_title "Removing Docker containers"
[ "$auto" = "true" ] || ask_warning "Are you sure you want to remove all local docker containers?"
[ "$?" = 0 ] || exit 1
docker rm $(docker ps -a -q)

