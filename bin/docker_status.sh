#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

echo_title "Docker version"
echo_subtitle "Executing: docker version"
docker version

echo_title "Latest Docker containers"
echo_subtitle "Executing: docker ps --all --last 10"
docker ps --all --last 10

echo_title "Docker images"
echo_subtitle "Executing: docker images"
docker images
