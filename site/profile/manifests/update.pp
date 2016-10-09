# This class managed system's packages updates
# via cron. A cron schedule has to be set in order
# to enable updates
#
class profile::update (
  String $cron_schedule = ''
) {

  $update_command = $::osfamily ? {
    'RedHat' => 'yum update -y',
    'Debian' => 'apt-get update ; apt-get upgrade -y',
    'Suse'   => 'zypper --non-interactive update',
  }
  if $cron_schedule != '' {
    file { '/etc/cron.d/system_update':
      ensure  => present,
      content => "# File managed by Puppet\n${cron_schedule} root ${update_command}\n",
    }
  } else {
    file { '/etc/cron.d/system_update':
      ensure  => absent,
    }
  }
}
