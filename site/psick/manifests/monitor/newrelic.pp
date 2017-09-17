# == Class: site::monitor::newrelic
#
class psick::monitor::newrelic (
  $ensure                     = 'present',

  $config_dir_source          = undef,
  $config_file_template       = 'psick/monitor/newrelic/nrsysmond.cfg.erb',
  $extra_config_file_template = undef,
) {

  $options_default = {
    license_key => 'CHANGEME',
    proxy       => $::psick::settings::http_proxy,
  }
  #
  $options_user=hiera_hash('newrelic_options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'newrelic':
    ensure => $ensure,
  }
  ::tp::dir { 'newrelic':
    ensure => $ensure,
    source => $config_dir_source,
  }
  ::tp::conf { 'newrelic':
    ensure       => $ensure,
    template     => $config_file_template,
    options_hash => $options,
  }

  ::tp::conf { 'newrelic::extra.conf':
    ensure       => $ensure,
    template     => $extra_config_file_template,
    options_hash => $options,
  }

}
