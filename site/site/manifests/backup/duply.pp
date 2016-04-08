# Backup Management
# Sample setup. Disabled by default.
#
class site::backup::duply (
  $ensure                  = 'present',
  $enable                  = false,

  $config_dir_source       = undef,
  $config_file_template    = 'site/duply/sample.conf.erb',
  $logrotate_file_template = 'site/duply/logrotate.conf.erb',
  $cron_schedule           = '30 3 * * *',
) {

  validate_bool($enable)

  if $ensure == 'absent' {
    ::tp::uninstall3 { 'duply': }
  } else {
    ::tp::install3 { 'duply': }
  }

  ::tp::dir3 { 'duply':
    ensure => $ensure,
    source => $duply_dir_source,
  } 

  # All the data used in templates can be stored on Hiera ( 'duply_options' key)
  # Here are defined the defaults (useful just for a POC) for the used templates
  $options_default = {
    'target'          => 'file:///backup',
    'source'          => '/etc',
    'max_age'         => '3M',
    'max_fullbkp_age' => '1M',
  }
  $options_user=hiera_hash('duply_options', {} )
  $options=merge($options_default,$options_user)

  ::tp::conf3 { 'duply::logs':
    ensure       => $ensure,
    template     => $config_file_template,
    options_hash => $options,
  }

  if $enable {
  # When enabled cronjob for automatic backups and log rotation are managed
    ::tp::conf3 { 'cron::duply':
      ensure   => $ensure,
      content  => "${cron_schedule} duply  backup_verify_purge --force ${log_file} 2>&1"
    }
    ::tp::conf3 { 'logrotate::duply.conf':
      ensure   => $ensure,
      template => $logrotate_file_template,
    }
  }
}
