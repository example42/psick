#!/bin/bash
repo_dir="$(dirname $0)/.."

echo "Cleanup keys"
rm -f ${repo_dir}/keys/*
echo
