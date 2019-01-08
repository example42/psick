#!/usr/bin/env bash
PATH=/opt/puppetlabs/puppet/bin:$PATH

if [ $USER == 'root' ]; then
  sudo_command=''
else
  sudo_command='sudo '
fi

$sudo_command puppet module install example42-tp

os=$(facter operatingsystem)
local_user=$(whoami)
case $os in
  Darwin*)
    $sudo_command puppet module install thekevjames-homebrew
    $sudo_command puppet apply -e "class { homebrew: user => $local_user }"
  ;;
  Windows*)
    $sudo_command puppet module install puppetlabs-chocolatey
    $sudo_command puppet apply -e "include chocolately"
  ;;
esac

$sudo_command puppet tp setup

