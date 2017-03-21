# This profile is included in all the Linux servers which are managed by Puppet.
# It exposes a list of parameters which define the name of the class to use for
# different common tasks. If the name is empty (as by default in most of the
# cases) no class is included.
# A special class name, customisable with the parameter pre_class defines the
# name of a class to include before all the others. This is the only case where
# a non empty class name must be defined.
# In the pre class you should define resources that are prerequisites for all
# the others, such as package repositories definition.
#
class profile::base::linux (

  # General switch. If false nothing is done.
  Boolean $enable           = true,

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
  String $timezone_class    = '',
  String $sysctl_class      = '',
  String $dns_class         = '',
  String $hardening_class   = '',
  String $limits_class      = '',
  String $hostname_class    = '',
  String $hosts_class       = '',
  String $update_class      = '',
  String $motd_class        = '',
  String $profile_class     = '',

) {

  if $enable {
    contain ::tools
    contain ::profile::settings
    contain $pre_class
    Class['::profile::settings'] -> Class[$pre_class]
  }

  if $network_class != '' and $enable {
    contain $network_class
    Class[$pre_class] -> Class[$network_class]
  }

  if $mail_class != '' and $enable {
    contain $mail_class
    Class[$pre_class] -> Class[$mail_class]
  }

  if $puppet_class != '' and $enable {
    contain $puppet_class
    Class[$pre_class] -> Class[$puppet_class]
  }

  if $ssh_class != '' and $enable {
    contain $ssh_class
    Class[$pre_class] -> Class[$ssh_class]
  }

  if $monitor_class != '' and $enable {
    contain $monitor_class
    Class[$pre_class] -> Class[$monitor_class]
  }

  if $backup_class != '' and $enable {
    contain $backup_class
    Class[$pre_class] -> Class[$backup_class]
  }

  if $users_class != '' and $enable {
    contain $users_class
    Class[$pre_class] -> Class[$users_class]
  }

  if $sudo_class != '' and $enable {
    contain $sudo_class
    Class[$pre_class] -> Class[$sudo_class]
  }

  if $firewall_class != '' and $enable {
    contain $firewall_class
    Class[$pre_class] -> Class[$firewall_class]
  }

  if $logs_class != '' and $enable {
    contain $logs_class
    Class[$pre_class] -> Class[$logs_class]
  }

  if $time_class != '' and $enable {
    contain $time_class
    Class[$pre_class] -> Class[$time_class]
  }

  if $timezone_class != '' and $enable {
    contain $timezone_class
    Class[$pre_class] -> Class[$timezone_class]
  }

  if $sysctl_class != '' and $enable {
    contain $sysctl_class
    Class[$pre_class] -> Class[$sysctl_class]
  }

  if $dns_class != '' and $enable {
    contain $dns_class
    Class[$pre_class] -> Class[$dns_class]
  }

  if $hardening_class != '' and $enable {
    contain $hardening_class
    Class[$pre_class] -> Class[$hardening_class]
  }

  if $limits_class != '' and $enable {
    contain $limits_class
    Class[$pre_class] -> Class[$limits_class]
  }

  if $hostname_class != '' and $enable {
    contain $hostname_class
    Class[$pre_class] -> Class[$hostname_class]
  }

  if $hosts_class != '' and $enable {
    contain $hosts_class
    Class[$pre_class] -> Class[$hosts_class]
  }

  if $update_class != '' and $enable {
    contain $update_class
    Class[$pre_class] -> Class[$update_class]
  }

  if $motd_class != '' and $enable {
    contain $motd_class
    Class[$pre_class] -> Class[$motd_class]
  }

  if $profile_class != '' and $enable {
    contain $profile_class
    Class[$pre_class] -> Class[$profile_class]
  }
}
