# This is the default manifest used in Vagrant and PuppetMaster
# environments.
#
# Here we have a $::role driven nodeless setup where
# we just include our site class where we include common and per role classes

# If Puppet is already 4.x we include the relevant site class
# otherwise we install Puppet 4 agent

if versioncmp($::puppetversion, '4.0.0') >= 0 {
  $kernel_down=downcase($::kernel)
  contain "::profile::${kernel_down}"

  # Role specific class is loaded, if $role is set
  if $::role and $::role != '' {
    contain "::role::${::role}"
    Class["::profile::${kernel_down}"] -> Class["::role::${::role}"]
  }

  # Alternative hiera driven classification
  hiera_include('profiles',[])

} else {
  include ::profile::puppet::v3::upgradeto4
}


