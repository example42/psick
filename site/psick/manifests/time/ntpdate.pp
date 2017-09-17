# This class installs and runs once ntpdate
class psick::time::ntpdate (
  # If given a ntpdate cron jon is scheduled. Format: * * * * *
  String $crontab    = '',

  # Server to sync to (just one)
  String $ntp_server = 'pool.ntp.org',
) {

  tp::install { 'ntpdate': }

  exec { "ntpdate -s ${ntp_server}":
    subscribe   => Tp::Install['ntpdate'],
    refreshonly => true,
  }
  if $crontab != '' and $::virtual != 'docker' {
    file { '/etc/cron.d/ntpdate':
      content => "${crontab} root ntpdate -s ${ntp_server}\n",
    }
  }
}
