# This is the default manifest used in Vagrant and PuppetMaster
# environments.
# Here we have a sample $::role driven nodeless setup with a common base profile
# Feel free to modify and adapt to your case.

# The following lines are used to assign to top-scope variables (used in
# hiera.yaml) the values of eventual trusted facts.
# More info: https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html
# You may need to change and adapt them according to your hiera.yaml
# You can keep them also if you don't set extended trusted facts.
if $trusted['extensions']['pp_role'] and !has_key($facts,'role') {
  $role = $trusted['extensions']['pp_role']
}
if $trusted['extensions']['pp_environment'] and !has_key($facts,'env') {
  $env = $trusted['extensions']['pp_environment']
}
if $trusted['extensions']['pp_datacenter'] and !has_key($facts,'datacenter') {
  $datacenter = $trusted['extensions']['pp_datacenter']
}
if $trusted['extensions']['pp_zone'] and !has_key($facts,'zone') {
  $zone = $trusted['extensions']['pp_zone']
}
if $trusted['extensions']['pp_application'] and !has_key($facts,'application') {
  $application = $trusted['extensions']['pp_application']
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
  'Windows': {
    File {
      owner => 'Administrator',
      group => 'Administrators',
      mode  => '0644',
    }
#    Exec {
#      path => '%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\',
#    } 
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
$noop_mode = lookup('noop_mode', Boolean, 'first', false)
if $noop_mode == true {
  noop()
}

# Workaround to permit compilation via puppet job run command
if defined('$facts') {

  # The tools module provides functions, types, providers, defines.
  # We include here the dummy, empty, main class.
  contain '::tools'

  # Profile::settings does not provide resources.
  # It's esclusively used to set variables (Hiera driven) available to
  # all profile classes
  contain '::profile::settings'

  # This class is evaluated first and must always be present
  # Should contain the minimal prerequisites for the base setup
  contain '::profile::pre'

  # General baseline classes are distinct for each OS kernel
  # With multi kernel clients better include dedicated base profiles.
  $kernel_down=downcase($::kernel)
  contain "::profile::base::${kernel_down}"

  # Class ordering
  Class['::tools'] ->
  Class['::profile::settings'] ->
  Class['::profile::pre'] ->
  Class["::profile::base::${kernel_down}"]

  # Classification option 1 - Profiles defined in Hiera
  # We contain all the classes defined on Hiera key: 'profiles'
  lookup('profiles', Array[String], 'unique', [] ).contain
  lookup('profiles', Array[String], 'unique', [] ).each | $p | {
    Class["::profile::base::${kernel_down}"] -> Class[$p]
  }

  # Classification option 2 - Classic roles and profiles classes
  # We contain role classes based on the $::role variable.
  #  if $::role and $::role != '' {
  #    contain "::role::${::role}"
  #    Class["::profile::base::${kernel_down}"] -> Class["::role::${::role}"]
  #  }

} else {
  # notify {"Executed via puppet orchestrator\n":}
  notice ("Executed via puppet orchestrator\n")
}

