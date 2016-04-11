#
class profile::mail::postfix (
  $ensure                     = 'present',

  $config_dir_source          = undef,
  $config_file_template       = undef,

) {

  $options_default = {
  }
  $options_user=hiera_hash('postfix_options', {} )
  $options=merge($options_default,$options_user){

  # Postfix as local mailer
  ::tp::install { 'postfix':
    ensure => $ensure,
  }
  ::tp::conf { 'postfix':
    ensure       => $ensure,
    template     => $config_file_template,
    options_hash => $options,
  }
  ::tp::dir { 'postfix':
    ensure => $ensure,
    source => $config_dir_source,
  }
}
