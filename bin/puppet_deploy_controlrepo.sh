#!/bin/bash
script_dir="$(dirname $0)"
# . "${script_dir}/functions"
PATH=$PATH:/usr/local/bin
control_repo=${1:-"https://github.com/example42/psick.git"}

echo "Installing prerequisite packages and gems"
puppet resource package git ensure=present

puppet resource package deep_merge ensure=present provider=puppet_gem
puppet resource package hiera-eyaml ensure=present provider=puppet_gem
puppet resource package r10k ensure=present provider=puppet_gem

mkdir -p /etc/puppetlabs/code/environments/
mkdir -p /etc/puppetlabs/r10k/
cat > /etc/puppetlabs/r10k/r10k.yaml << EOF
---
:postrun: []
:cachedir: /opt/puppetlabs/puppet/cache/r10k
:sources:
  puppet:
    basedir: /etc/puppetlabs/code/environments
    remote: $control_repo
EOF

echo "Running r10k deploy environment -v"
/opt/puppetlabs/puppet/bin/r10k deploy environment -v

