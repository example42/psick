# Class to manage keepalived with static data
# Use psick::lb::keepalived + psick::lb::balanced_host
# for dynamic management based on exported resurces
#
class psick::lb::keepalived_static (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = 'psick/lb/keepalived/keepalived.conf.erb',
) {

  $options_default = {
    'notification_email_from' => "info@${::domain}",
    'smtp_server'             => 'localhost',
    'smtp_connect_timeout'    => '30',
    'lvs_id'                  =>  $::hostname,
  }
  $virtualservers=hiera_hash('lb_virtualservers', {} )
  $options_user=hiera_hash('psick::lb::keepalived_static::options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'keepalived':
    ensure => $ensure,
  }

  if $config_file_template != '' {
    ::tp::conf { 'keepalived':
      ensure       => $ensure,
      template     => $config_file_template,
      options_hash => $options,
    }
  }

  ::tp::dir { 'keepalived::services':
    ensure => $ensure,
    path   => '/etc/keepalived/services',
    source => $config_dir_source,
  }

  $virtualservers.each | $vs , $params | {
    tools::keepalived::virtualserver_static { $vs:
      * => $params,
    }
  }

}
