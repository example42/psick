#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
. "${script_dir}/functions"
PATH=/opt/puppetlabs/puppet/bin:$PATH

[ "$1" = "auto" ] && auto=true || auto=false

puppet_options="--modulepath ${repo_dir}/site:${repo_dir}/modules:/etc/puppet/modules --environmentpath ${repo_dir}"

setup_puppet() {
  echo_title "Setting up Puppet environment"
  if [ "$auto" == "true" ]; then
    "${script_dir}/puppet_setup.sh" auto
  else
    "${script_dir}/puppet_setup.sh"
  fi
}

install_fabric() {
  [ "$auto" == "true" ] || ask_interactive "Going to install Fabric via Puppet"
  [ "$?" = 0 ] || return
  "${script_dir}/fabric_setup.sh"
}

install_vagrant() {  
  [ "$auto" = "true" ] || ask_interactive "Going to install Vagrant via Puppet"
  [ "$?" = 0 ] || return
  "${script_dir}/vagrant_setup.sh"
}

install_docker() { 
  [ "$auto" = "true" ] || ask_interactive "Going to install Docker via Puppet"
  [ "$?" = 0 ] || return
  "${script_dir}/docker_setup.sh"
}

setup_puppet
install_fabric
install_vagrant
install_docker

