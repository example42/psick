# This class manages the installation and configuration of rsyslog via tp
#
# @param ensure If to install or remove the rsyslog package
# @param config_dir_source The source to use (as used in source =>) to populate
#                          the whole rsyslog configuration directory
# @param config_file_template The erb template (as used in template()) to manage
#                             the content of the rsyslog main configuration file
# @param server_ip An array of IPs o syslog servers where to send logs
# @param options An open hash of options to use in the provided template.
#                Note: This variable is not a class paramenter but it's looked
#                up with hiera_hash('psick::logs::rsyslog::options', {} )
#
class psick::logs::rsyslog (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = '',
  Array                    $server_ip                  = [],
) {

  $options_default = {
  }
  $options_user=hiera_hash('psick::logs::rsyslog::options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'rsyslog':
    ensure => $ensure,
  }

  if $config_file_template != '' {
    ::tp::conf { 'rsyslog':
      ensure       => $ensure,
      template     => $config_file_template,
      options_hash => $options,
    }
  }

  ::tp::dir { 'rsyslog':
    ensure => $ensure,
    source => $config_dir_source,
  }

  if $::os['family'] == 'RedHat' and $::os['release']['major'] == '7' {
    ::tp::conf { 'rsyslog::20-default.conf':
      ensure       => $ensure,
      template     => 'psick/logs/rsyslog/20-default.erb',
      options_hash => $options,
      base_dir     => 'conf',
    }
    ::tp::conf { 'rsyslog::50-default.conf':
      ensure       => $ensure,
      template     => 'psick/logs/rsyslog/50-default.erb',
      options_hash => $options,
      base_dir     => 'conf',
    }
  }

  if $server_ip != [] {
    ::tp::conf { 'rsyslog::60-syslogserver.conf':
      ensure       => $ensure,
      template     => 'psick/logs/rsyslog/60-syslogserver.erb',
      base_dir     => 'conf',
      options_hash => { server_ip => $server_ip },
    }
  }
}
