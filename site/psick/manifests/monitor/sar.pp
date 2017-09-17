# Installs and configures sar
#
class psick::monitor::sar (
  String $ensure        = 'present',
  String $check_cron    = '*/5 * * * *',
  String $summary_cron  = '53 23 * * *',
  String $cron_template = 'psick/sar/systat.cron.erb',
) {
  package { 'sysstat':
    ensure => $ensure,
  }
  file { '/etc/cron.d/sysstat':
    ensure  => $ensure,
    content => template($cron_template),
  }
}
