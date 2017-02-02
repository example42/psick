# This class manages the installation and configuration of snmpd via tp
#
# @param ensure If to install or remove the snmpd package
# @param config_dir_source The source to use (as used in source =>) to populate
#                          the whole snmpd configuration directory
# @param config_file_template The erb template (as used in template()) to manage
#                             the content of the snmpd main.cf file
# @param options An open hash of options to use in the provided template. Their
#                keys are merged with some class defaults
#                Note: This variable is not a class paramenter but it's looked
#                up with hiera_hash('profile::logs::snmpd::options', {} )
# @param serverif The primary server IP. Default value is from
#                 $::profile::settings::primary_ip
# @param is_cluster If the server is a cluster member. If so extra configs are
#                   added to the default template
# @param extra_packages An array of extra snmdp related packages to install
#
class profile::monitor::snmpd (
  Array                    $extra_packages             = [],
  Enum['present','absent'] $ensure                     = 'present',
  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = '',
  String                   $serverif                   = $::profile::settings::primary_ip,
) {

  $options_default = {
    'rocommunity' => 'public',
  }

  $options_user=hiera_hash('profile::monitor::snmpd::options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'snmpd':
    ensure        => $ensure,
  }

  $extra_packages.each |$pkg| {
    ensure_packages($pkg)
  }

  if $config_file_template != '' {
    ::tp::conf { 'snmpd':
      ensure       => $ensure,
      template     => $config_file_template,
      options_hash => $options,
    }
  }

  ::tp::dir { 'snmpd':
    ensure => $ensure,
    source => $config_dir_source,
  }
}
