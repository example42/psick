#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
. "${script_dir}/functions"

[ "$1" = "auto" ] && auto=true || auto=false

puppet_options="--modulepath ${repo_dir}/site:${repo_dir}/modules:/etc/puppet/modules --environmentpath ${repo_dir}"

setup_puppet() {
  echo_title "Setting up Puppet environment"
  if [ "$auto" = "true" ]; then
    "${script_dir}/puppet_setup.sh" auto
  else
    "${script_dir}/puppet_setup.sh"
  fi
}

install_fabric() {
  [ "$auto" = "true" ] || ask_interactive "Going to install Fabric via Puppet"
  [ "$?" = 0 ] || return
  echo_title "Installing Fabric"
  echo_subtitle "Executing: sudo puppet apply -e 'include ::psick::python::fabric'"
  sudo -E puppet apply $puppet_options -e 'include ::psick::python::fabric'
}

install_vagrant() {  
  [ "$auto" = "true" ] || ask_interactive "Going to install Vagrant via Puppet"
  [ "$?" = 0 ] || return
  echo_title "Installing Vagrant"
  echo_subtitle "Executing: sudo puppet apply -e 'include ::psick::vagrant'"
  sudo -E puppet apply $puppet_options -e 'include ::psick::vagrant'
  echo_subtitle "Executing: puppet apply -e 'include ::psick::vagrant::plugins'"
  sudo -E puppet apply $puppet_options -e 'include ::psick::vagrant::plugins'
}

install_docker() { 
  [ "$auto" = "true" ] || ask_interactive "Going to install Docker via Puppet"
  [ "$?" = 0 ] || return
  echo_title "Installing Docker"
  echo_subtitle "Executing: sudo puppet apply -e 'include ::psick::docker'"
  sudo -E puppet apply $puppet_options -e 'include ::psick::docker'
}

setup_puppet
install_fabric
install_vagrant
install_docker

