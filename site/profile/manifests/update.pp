# This class managed system's packages updates
# via cron
#
class profile::update (
  String $cron_schedule        = '',
  Boolean $reboot_after_update = false,
  String $update_template      = 'profile/update/update.sh.erb',
  String $update_script_path   = '/usr/local/sbin/update.sh',
) {

  if $cron_schedule != '' {
    file { '/etc/cron.d/system_update':
      ensure  => present,
      content => "# File managed by Puppet\n${cron_schedule} root ${update_script_path}\n",
    }
  } else {
    file { '/etc/cron.d/system_update':
      ensure  => absent,
    }
  }

  file { $update_script_path:
    ensure  => present,
    mode    => '0750',
    content => template($update_template),
    before  => File['/etc/cron.d/system_update'],
  }
}
