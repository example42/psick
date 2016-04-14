#!/bin/bash
facts_dir=$(puppet config print pluginfactdest)
mkdir -p $facts_dir
echo "## Setting external facts role=${1} and env=vagrant" 
echo "role=$1" > $facts_dir/role.txt
echo "env=vagrant" > $facts_dir/env.txt
