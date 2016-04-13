#!/bin/bash
facts_dir=$(puppet config print pluginfactdest)
mkdir -p $facts_dir
echo "## Setting external facts role=${role} and env={env}" 
echo "role=$1" > $facts_dir/role.txt
echo "env=devel" > $facts_dir/env.txt
