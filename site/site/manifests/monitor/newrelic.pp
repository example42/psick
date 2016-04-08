# == Class: site::monitor::newrelic
#
class site::monitor::newrelic (
  $ensure                     = 'present',

  $config_dir_source          = undef,
  $config_file_template       = 'site/monitor/newrelic/nrsysmond.cfg.erb',
  $extra_config_file_template = undef,
) {

  $options_default = {
    license_key => 'CHANGEME',
  }
  #
  $options_user=hiera_hash('newrelic_options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install3 { 'newrelic':
    ensure => $ensure,
  }
  ::tp::dir3 { 'newrelic':
    ensure => $ensure,
    source => $config_dir_source,
  }
  ::tp::conf3 { 'newrelic':
    ensure       => $ensure,
    template     => $config_file_template,
    options_hash => $options,
  }

  ::tp::conf3 { 'newrelic::extra.conf':
    ensure       => $ensure,
    template     => $extra_config_file_template,
    options_hash => $options,
  } 
  
}
