# This class installs and configures openssh
#
# @param ensure                 Default: present
#   If openssh should be present or absent: present (default value) or absent
#
# @param configure_dir_source   Default: undef
#   The source content.
#
# @param config_file_template   Default ''
#   The path to an erb template to use to populate the openssh configuration file:
#   If the value is set to the empty string no openssh configuration file will be created.
#

class psick::ssh::openssh (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = '',
) {

  $options_default = {
  }
  $options_user=hiera_hash('psick::ssh::openssh::options', {} )
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

