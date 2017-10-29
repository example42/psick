#!/bin/bash
env=${1:-production}
mount_dir=${2:-'/vagrant_puppet'}

link_controlrepo() {
  echo "### Linking Puppet ${env} environment to local development directory."
  [ -d /etc/puppetlabs/code/environments ] || mkdir -p /etc/puppetlabs/code/environments
  [ -d /etc/puppetlabs/code/environments/$env ] && mv /etc/puppetlabs/code/environments/$env /etc/puppetlabs/code/environments/$env_$(date +%Y%m%d_%H%M%S)
  ln -sf $mount_dir /etc/puppetlabs/code/environments/$env
}

[ -L /etc/puppetlabs/code/environments/$env ] || link_controlrepo $env

