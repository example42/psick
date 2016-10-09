# This class installs and configures openssh
#
class profile::ssh::openssh (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = '',
) {

  $options_default = {
  }
  $options_user=hiera_hash('profile::ssh::openssh::options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'openssh':
    ensure => $ensure,
  }

  if $config_file_template != '' {
    ::tp::conf { 'openssh':
      ensure       => $ensure,
      template     => $config_file_template,
      options_hash => $options,
    }
  }

  ::tp::dir { 'openssh':
    ensure => $ensure,
    source => $config_dir_source,
  }

}

