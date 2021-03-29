#!/bin/bash

puppet_version=$1
puppet_role=$2
control_repo=$3

echo "### Installing git"
git --version &>/dev/null
GIT_IS_AVAILABLE=$?

if [[ ! $GIT_IS_AVAILABLE -eq 0 ]]; then
  if [ -f /etc/debian_version ]; then
    apt update  &>/dev/null
    apt install -y git &>/dev/null
  fi

  if [ -f /etc/redhat-release ]; then
    yum install -y git &>/dev/null
  fi
fi

echo "### Cloning PSICK"
git clone $control_repo /tmp/psick &>/dev/null
pushd /tmp/psick

echo "### Set external facts"
bin/puppet_set_external_facts.sh --role $puppet_role --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'

echo "### Set trusted facts"
bin/puppet_set_trusted_facts.sh --role $puppet_role --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'

echo "### Installing Puppet"
bin/puppet_install.sh $puppet_version
popd

if [ $puppet_role == 'puppet' ]; then
  pushd /tmp/psick

  echo "### Installing puppetserver"
  puppet resource package puppetserver ensure=present &>/dev/null

  echo "### Installing puppet agent gems"
  puppet resource package r10k ensure=present provider=puppet_gem &>/dev/null

  echo "### Deploy control-repository"
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

  echo "### Running r10k deploy environment -v"
  /opt/puppetlabs/puppet/bin/r10k deploy environment -p &>/dev/null

  echo "### Starting Puppet Server"
  /opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true &>/dev/null
  popd
fi

rm -fr /tmp/psick
