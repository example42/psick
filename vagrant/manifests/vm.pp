# Define: vagrant::vm
#
# Inserts a vm in a vagrant environment 
#
# Parameters:
#
# TODO: 
# - Solve limit of single forward port and share per vm
# - Add vm configs settings
#
# Usage:
# You have to define at least one vagrant::environment and there place a
# Vagrantfile populated with one or multiple VMs
# vagrant::environment { "test42": user => "al" }
# vagrant::vm { "test-lucid64": environment => "test42" , box => "lucid64" , box_url => "http://files.vagrantup.com/lucid64.box" }
#
#
define vagrant::vm (
    $environment,
    $box="base",
    $box_url="",
    $forward_name="",
    $forward_hostport="",
    $forward_guestport="",
    $share_name="",
    $share_hostdir="",
    $share_guestmount="",
    $network="",
    $boot_mode="",
    $provision="",
    $puppet_server="$puppet_server",
    $puppet_node="$fqdn",
    $chef_orgname="",
    $order="50",
    $ensure="present" ) {

    include vagrant::params
    include concat::setup

    concat::fragment{ "Vagrantfile_vm_$environment_$name":
        target  => "${vagrant::params::basedir}/${environment}/Vagrantfile",
        content => template("vagrant/concat/Vagrantfile_vm.erb"),
        order   => $order,
        ensure  => $ensure,
    }

}
