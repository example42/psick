# This profile triggers a system reboot
#
# This profiles uses puppetfile/reboot module to manage
# system reboots. It's supposed to be used in firstrun mode.
#
# @example Enable firstrun mode and set reboot class on windows
#   and linux
#   firstrun_enable: true
#   profile::firstrun::linux::reboot_class: profile::reboot
#   profile::firstrun::windows::reboot_class: profile::reboot
#
class profile::reboot (
  Enum['immediately','finished'] $apply = 'finished',
  Enum['refreshed','pending'] $when     = 'refreshed',
  String $message     = 'firstboot mode enabled, rebooting after first Puppet run',
  String $reboot_name = 'Rebooting',
  Integer $timeout    = 60,
) {
  reboot { $reboot_name:
    apply   => $apply,
    message => $message,
    when    => $when,
    timeout => $timeout,
  }
}
