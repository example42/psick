#!/bin/bash
repo_dir="$(dirname $0)/../"
which gem || echo "You need gem support! Install rubygems to continue successfully" 
echo "# Installing gems"
gem install deep_merge
gem install hiera-eyaml
gem install r10k

echo 
cd $repo_dir
echo "# Installing external modules via r10k"
r10k puppetfile install -v
echo

progs="puppet vagrant docker fab"
for prog in $progs; do
  echo "# Checking ${prog} availability"
  which $prog || echo "${prog} not found. Installation is recommended."
  echo
done
