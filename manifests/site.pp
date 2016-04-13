# This is the default manifest used in Vagrant and PuppetMaster
# environments.
#
# Here we have a $::role driven nodeless setup where
# we just include our site class where we include common and per role classes

# If Puppet is already 4.x we include the relevant site class
# otherwise we install Puppet 4 agent

if versioncmp($::puppetversion, '4.0.0') >= 0 {
  case $::kernel {
    'windows': { include ::profile::windows }
    'Solaris': { include ::profile::solaris }
    'Linux': { include ::profile::linux }
    default: { fail("Unsupported Operating System ${::kernel}") }
  }
} else {
  include ::profile::puppet::v3::upgradeto4
}
