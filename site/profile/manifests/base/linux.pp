# Common linux profile
#
# Use _class params for exceptions and alternatives.
#
class profile::base::linux (

  String $pre_class         = '::profile::repo::generic',

  String $network_class     = '',
  String $mail_class        = '',
  String $puppet_class      = '',
  String $ssh_class         = '',
  String $users_class       = '',
  String $sudo_class        = '',
  String $monitor_class     = '',
  String $firewall_class    = '',
  String $logs_class        = '',
  String $backup_class      = '',
  String $time_class        = '',
  String $sysctl_class      = '',
  String $dns_class         = '',
  String $hardening_class   = '',
  String $limits_class      = '',

) {

  if $pre_class != '' {
    contain $pre_class
  }

  if $network_class != '' {
    contain $network_class
    Class[$pre_class] -> Class[$network_class]
  }

  if $mail_class != '' {
    contain $mail_class
    Class[$pre_class] -> Class[$mail_class]
  }

  if $puppet_class != '' {
    contain $puppet_class
    Class[$pre_class] -> Class[$puppet_class]
  }

  if $ssh_class != '' {
    contain $ssh_class
    Class[$pre_class] -> Class[$ssh_class]
  }

  if $monitor_class != '' {
    contain $monitor_class
    Class[$pre_class] -> Class[$monitor_class]
  }

  if $backup_class != '' {
    contain $backup_class
    Class[$pre_class] -> Class[$backup_class]
  }

  if $users_class != '' {
    contain $users_class
    Class[$pre_class] -> Class[$users_class]
  }

  if $sudo_class != '' {
    contain $sudo_class
    Class[$pre_class] -> Class[$sudo_class]
  }

  if $firewall_class != '' {
    contain $firewall_class
    Class[$pre_class] -> Class[$firewall_class]
  }

  if $logs_class != '' {
    contain $logs_class
    Class[$pre_class] -> Class[$logs_class]
  }

  if $time_class != '' {
    contain $time_class
    Class[$pre_class] -> Class[$time_class]
  }

  if $sysctl_class != '' {
    contain $sysctl_class
    Class[$pre_class] -> Class[$sysctl_class]
  }

  if $dns_class != '' {
    contain $dns_class
    Class[$pre_class] -> Class[$dns_class]
  }

  if $hardening_class != '' {
    contain $hardening_class
    Class[$pre_class] -> Class[$hardening_class]
  }

  if $limits_class != '' {
    contain $limits_class
    Class[$pre_class] -> Class[$limits_class]
  }

}
