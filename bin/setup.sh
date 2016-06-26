#!/bin/bash
repo_dir="$(dirname $0)/../"

gem install deep_merge
gem install hiera-eyaml
gem install r10k
cd $repo_dir
r10k puppetfile install -v

