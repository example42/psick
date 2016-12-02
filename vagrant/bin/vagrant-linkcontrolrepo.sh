#!/bin/bash

link_controlrepo() {
  echo "### Linking Puppet production environment to local development directory."
  mv /etc/puppetlabs/code/environments/production /etc/puppetlabs/code/environments/production_$(date +%Y%m%d_%H%M%S)
  ln -sf /etc/puppetlabs/code/environments/development /etc/puppetlabs/code/environments/production 
}

[ -L /etc/puppetlabs/code/environments/production ] || link_controlrepo

