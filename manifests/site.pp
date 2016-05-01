# This is the default manifest used in Vagrant and PuppetMaster
# environments.
# Here we have a sample $::role driven nodeless setup with a common base profile
#
# First some resource defaults
Tp::Install {
  test_enable  => hiera('tp::test_enable', false),
  puppi_enable => hiera('tp::puppi_enable', false),
  debug => hiera('tp::debug', false),
  data_module  => hiera('tp::data_module', 'tinydata'),
}
Tp::Conf {
  config_file_notify => hiera('tp::config_file_notify', true),
  config_file_require => hiera('tp::config_file_require', true),
  debug => hiera('tp::debug', false),
  data_module  => hiera('tp::data_module', 'tinydata'),
}
Tp::Dir {
  config_dir_notify => hiera('tp::config_dir_notify', true),
  config_dir_require => hiera('tp::config_dir_require', true),
  debug  => hiera('tp::debug', false),
  data_module  => hiera('tp::data_module', 'tinydata'),
}


# If Puppet is already 4.x we include the relevant site class
# otherwise we install Puppet 4 agent

if versioncmp($::puppetversion, '4.0.0') >= 0 {

  # A general base profile is included for Linux / Windows / Solaris
  $kernel_down=downcase($::kernel)
  contain "::profile::base::${kernel_down}"

  # Profiles to include in roles are defined via Hiera
  hiera_include('profiles',[])

  # Alternative based on role classes, if $role is set
  #  if $::role and $::role != '' {
  #    contain "::role::${::role}"
  #    Class["::profile::base::${kernel_down}"] -> Class["::role::${::role}"]
  #  }

} else {
  include ::profile::puppet::v3::upgradeto4
}

