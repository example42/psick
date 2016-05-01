#!/bin/bash

puppet resource package rubygems ensure=present

gem list | grep deep_merge >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  echo "## Installing deep_merge gem"
  gem install --no-ri --no-rdoc deep_merge
fi
gem list | grep hiera-eyaml >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  echo "## Installing hiera-eyaml gem for shell"
  gem install --no-ri --no-rdoc hiera-eyaml
fi
/opt/puppetlabs/puppet/bin/gem list | grep hiera-eyaml >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  echo "## Installing hiera-eyaml gem for puppet"
  /opt/puppetlabs/puppet/bin/gem install --no-ri --no-rdoc hiera-eyaml
fi

ln -sf /etc/puppetlabs/code/environments/production/hiera.yaml /etc/puppetlabs/code/hiera.yaml
