# This class installs and configures snmpd
#
class profile::monitor::snmpd (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = '',
) {

  $options_default = {
    'ro_community'    => 'public',
  }
  $options_user=hiera_hash('profile::monitor::snmpd::options', {} )
  $options=merge($options_default,$options_user)
  $extra_packages = $::osfamily ? {
    'RedHat' => [ 'net-snmp-utils' ],
    default  => [],
  }

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
