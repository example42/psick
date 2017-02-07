#!/bin/bash

puppet resource package git ensure=present

if [ $(facter osfamily) == 'Debian' ]; then
  puppet resource package ruby ensure=present
else
  puppet resource package rubygems ensure=present
fi

puppet resource package deep_merge ensure=present provider=gem
puppet resource package hiera-eyaml ensure=present provider=gem
puppet resource package r10k ensure=present provider=gem

mkdir -p /etc/puppetlabs/code/environments/
git clone git://github.com/example42/control-repo.git /etc/puppetlabs/code/environments/production
cd /etc/puppetlabs/code/environments/production
r10k puppetfile install -v

ln -sf /etc/puppetlabs/code/environments/production/docs/hiera.yaml /etc/puppetlabs/code/hiera.yaml
