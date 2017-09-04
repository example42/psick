# This is the default manifest used in Vagrant and PuppetMaster environments.

# Here we have a sample $::role driven nodeless setup with a common base profile
# a additional classes (profiles) set on Hiera.
# The $::role variable, useful for classification in Hiera, can be set in different ways:
# - As an external fact defined during provisioning
# - Via a ENC like The Foreman or Puppet Enterprise
# - In this same site.pp, extracting the role information from the hostname
# - In this same site.pp, setting the $role var based on pp_role trusted fact
# The latter choice is what is used here, feel free to modify and adapt to your case.

### SETTING TOP SCOPE VARIABLES USED IN HIERA.YAML
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
# Note: the above settings allow override or trusted factes by normal facts.
# This is done here to adapt to different approaches, if you use trusted facts
# you will probably want to change the above into something like:
# if $trusted['extensions']['pp_role'] {
#   $role = $trusted['extensions']['pp_role']
# }


### RESOURCE DEFAULTS
# Some resource defaults for Files, Execs and Tiny Puppet
case $::kernel {
  'Darwin': {
    File {
      owner => 'root',
      group => 'wheel',
      mode  => '0644',
    }
    Exec {
     path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
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
    Exec {
      path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    }
  }
}
Tp::Install {
  cli_enable  => lookup('tp::cli_enable', Boolean, 'first', false),
  test_enable  => lookup('tp::test_enable', Boolean, 'first', false),
  puppi_enable => lookup('tp::puppi_enable', Boolean, 'first', false),
  debug => lookup('tp::debug', Boolean, 'first', false),
  data_module  => lookup('tp::data_module', String, 'first', 'tinydata'),
}
Tp::Conf {
  config_file_notify => lookup('tp::config_file_notify', Boolean, 'first', true),
  config_file_require => lookup('tp::config_file_require', Boolean, 'first', true),
  debug => lookup('tp::debug', Boolean, 'first', false),
  data_module  => lookup('tp::data_module', String, 'first', 'tinydata'),
}
Tp::Dir {
  config_dir_notify => lookup('tp::config_dir_notify', Boolean, 'first', true),
  config_dir_require => lookup('tp::config_dir_require', Boolean, 'first', true),
  debug  => lookup('tp::debug', Boolean, 'first', false),
  data_module  => lookup('tp::data_module', String, 'first', 'tinydata'),
}

### ADDITIONS FOR RUNS INSIDE DOCKER IMAGES AND NOOP MODE
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

### ACTUAL CLASSES INCLUDED IN NODES

# Workaround to permit compilation via puppet job run command
# The $facts variable is always present in normal conditions.
if defined('$facts') {

  # The tools module provides functions, types, providers, defines.
  # We include here the dummy, empty, main class in order to be able
  # to access to its components
  contain '::tools'

  # Profile::settings does not provide resources.
  # It's esclusively used to set variables (Hiera driven) available to
  # all profile classes
  contain '::profile::settings'

  # General prerequisites and baseline classes are included in all the
  # nodes. They are distinct for each OS kernel.
  # pre class contains the resources we want to manage before anything else
  # base class manages resources we want on all the nodes
  $kernel_down=downcase($::kernel)
  contain "::profile::pre::${kernel_down}"
  contain "::profile::base::${kernel_down}"

  # Explicit class ordering
  Class['::tools'] -> # lint:ignore:arrow_on_right_operand_line
  Class['::profile::settings'] -> # lint:ignore:arrow_on_right_operand_line
  Class["::profile::pre::${kernel_down}"] -> # lint:ignore:arrow_on_right_operand_line
  Class["::profile::base::${kernel_down}"]

  # Classification option 1 - Additional profiles defined in Hiera
  # We contain and order all the classes defined on Hiera key: 'profiles'
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

