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

  # With multi kernel clients better include different base profiles classes.
  $kernel_down=downcase($::kernel)
  contain "::profile::base::${kernel_down}"

  # Classification option 1 - Profiles defined in Hiera
  hiera_include('profiles',[])

  # Classification option 2 - Classic roles and profiles classes:
  #  if $::role and $::role != '' {
  #    contain "::role::${::role}"
  #    Class["::profile::base::${kernel_down}"] -> Class["::role::${::role}"]
  #  }

} else {
  # All the code here is Puppet 4 only compliant.
  # Nodes with Puppet 3 are upgraded
  include ::puppet::profile::upgradeto4
}

