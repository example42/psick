# This class manages the installation and configuration of virtualbox via tp
#
# @param ensure If to install or remove the virtualbox package
# @param config_dir_source The source to use (as used in source =>) to populate
#                          the whole virtualbox configuration directory
# @param config_file_template The erb template (as used in template()) to manage
#                             the content of the virtualbox main.cf file
# @param options An open hash of options to use in the provided template.
#                Note: This variable is not a class paramenter but it's looked
#                up with hiera_hash('psick::logs::virtualbox::options', {} )
#
class psick::virtualbox (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = '',
) {

  $options_default = {
  }
  $options_user=hiera_hash('psick::mail::virtualbox::options', {} )
  $options=merge($options_default,$options_user)

  # Postfix as local mailer
  ::tp::install { 'virtualbox':
    ensure => $ensure,
  }

  if $config_file_template != '' {
    ::tp::conf { 'virtualbox':
      ensure       => $ensure,
      template     => $config_file_template,
      options_hash => $options,
    }
  }

  ::tp::dir { 'virtualbox':
    ensure => $ensure,
    source => $config_dir_source,
  }
}
