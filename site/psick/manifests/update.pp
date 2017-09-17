# This class managed system's packages updates via cron
#
# @param cron_schedule The cron schedule to use for System Updates. If not set
#                      no automatic update is done (unless use_yum_cron is true)
# @parma reboot_after_update If to automatically reboot the system after an
#                            update (when an reboot is needed)
# @param update_template The erb template to use for the update_script_path
# @param update_script_path The path of the script used for system updates
# @param use_yum_cron If to install (only on RedHat derivatives) the yum_cron
#                     package (via the ::psick::yum_cron class).
#                     If true, the other options are ignored.
#
class psick::update (
  String $cron_schedule        = '',
  Boolean $reboot_after_update = false,
  String $update_template      = 'psick/update/update.sh.erb',
  String $update_script_path   = '/usr/local/sbin/update.sh',
  Boolean $use_yum_cron        = false,
) {

  if $::osfamily == 'RedHat' and $use_yum_cron {
    include ::psick::yum_cron
    file { '/etc/cron.d/system_update':
      ensure  => absent,
    }
  } else {
    # Custom update script
    if $cron_schedule != '' {
      file { '/etc/cron.d/system_update':
        ensure  => file,
        content => "# File managed by Puppet\n${cron_schedule} root ${update_script_path}\n",
      }
    } else {
      file { '/etc/cron.d/system_update':
        ensure  => absent,
      }
    }

    file { $update_script_path:
      ensure  => file,
      mode    => '0750',
      content => template($update_template),
      before  => File['/etc/cron.d/system_update'],
    }
  }
}
