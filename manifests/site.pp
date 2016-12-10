# This is the default manifest used in Vagrant and PuppetMaster
# environments.
# Here we have a sample $::role driven nodeless setup with a common base profile
# Feel free to modify and adapt to your case.

# The following lines are used to assign to top-scope variables (used in
# hiera.yaml) the values of eventual trusted facts.
# More info: https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html
# You may need to change and adapt them according to your hiera.yaml
# You can keep them also if you don't set extended trusted facts.
if $trusted['extensions']['pp_role'] {
  $role = $trusted['extensions']['pp_role']
}
if $trusted['extensions']['pp_environment'] {
  $env = $trusted['extensions']['pp_environment']
}
if $trusted['extensions']['pp_datacenter'] {
  $zone = $trusted['extensions']['pp_datacenter']
}

# Some resource defaults for Files, Execs and Tiny Puppet
case $::kernel {
  'Darwin': {
    File {
      owner => 'root',
      group => 'wheel',
      mode  => '0644',
    }
  }
  default: {
    File {
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
  }
}
Exec {
  path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}
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

# Building Docker container support
# This has a fix for service provider on docker
if $virtual == 'docker' {
  include ::dummy_service
}

# A useful trick to manage noop mode via hiera using the key: noop_mode
# This needs the trlinklin-noop module
$noop_mode = hiera('noop_mode', false)
if $noop_mode == true {
  noop()
}

# This is a Puppet 4 only control-repo, if Puppet is already 4.x
# we include the OS base profile and look for profiles on Hiera
# otherwise we install the Puppet 4 agent

if versioncmp($::puppetversion, '4.0.0') >= 0 {

  # With multi kernel clients better include dedicated base profiles.
  $kernel_down=downcase($::kernel)
  contain "::profile::base::${kernel_down}"

  # Classification option 1 - Profiles defined in Hiera
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

