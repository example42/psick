#
class profile::monitor::snmpd (
  Array                    $extra_packages,
  Enum['present','absent'] $ensure                     = 'present',
  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = '',
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
