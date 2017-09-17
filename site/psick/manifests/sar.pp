# Installs and configures sar
# Default settings manage SAR with checks every 5 minutes and daily summary
# creation.
#
# @param ensure if to install sysstat and create the /etc/cron.d/sysstat file
# @param check_cron The cron schedule for check interval. Default: */5 * * * *
# @param summary_cron The cron schedule for summary creation. Def: 53 23 * * *
# @param cron_template The erb template to use for the /etc/cron.d/sysstat file
#
class psick::sar (
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
