# The base profile included on all linux systems.
# 
# By default it does not manage any resource.
# It exposes a list of parameters which define the name of the class to use for
# different common tasks. If the name is empty (as always by default)
# no class is included.
#
# @example Manage some resources with relevant modules or profiles
#   profile::base::linux::puppet_class: '::puppet'
#   profile::base::linux::users_class: '::profile::users::static'
#
# @example Completely disable management of any resource from this class
#   profile::base::linux::manage: false
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the base profile.
#
# @param_$class All the other parameters are used to define the name of the
#   class for include in order to manage a specific system configuration.
#
class profile::base::linux (

  # General switch. If false nothing is done.
  Boolean $manage         = true,

  String $network_class   = '',
  String $mail_class      = '',
  String $puppet_class    = '',
  String $ssh_class       = '',
  String $users_class     = '',
  String $sudo_class      = '',
  String $monitor_class   = '',
  String $firewall_class  = '',
  String $logs_class      = '',
  String $backup_class    = '',
  String $time_class      = '',
  String $timezone_class  = '',
  String $sysctl_class    = '',
  String $dns_class       = '',
  String $hardening_class = '',
  String $limits_class    = '',
  String $hostname_class  = '',
  String $hosts_class     = '',
  String $update_class    = '',
  String $motd_class      = '',
  String $profile_class   = '',
  String $hardware_class  = '',
  String $multipath_class = '',
) {

  if $network_class != '' and $manage {
    contain $network_class
  }

  if $mail_class != '' and $manage {
    contain $mail_class
  }

  if $puppet_class != '' and $manage {
    contain $puppet_class
  }

  if $ssh_class != '' and $manage {
    contain $ssh_class
  }

  if $monitor_class != '' and $manage {
    contain $monitor_class
  }

  if $backup_class != '' and $manage {
    contain $backup_class
  }

  if $users_class != '' and $manage {
    contain $users_class
  }

  if $sudo_class != '' and $manage {
    contain $sudo_class
  }

  if $firewall_class != '' and $manage {
    contain $firewall_class
  }

  if $logs_class != '' and $manage {
    contain $logs_class
  }

  if $time_class != '' and $manage {
    contain $time_class
  }

  if $timezone_class != '' and $manage {
    contain $timezone_class
  }

  if $sysctl_class != '' and $manage {
    contain $sysctl_class
  }

  if $dns_class != '' and $manage {
    contain $dns_class
  }

  if $hardening_class != '' and $manage {
    contain $hardening_class
  }

  if $limits_class != '' and $manage {
    contain $limits_class
  }

  if $hostname_class != '' and $manage {
    contain $hostname_class
  }

  if $hosts_class != '' and $manage {
    contain $hosts_class
  }

  if $update_class != '' and $manage {
    contain $update_class
  }

  if $motd_class != '' and $manage {
    contain $motd_class
  }

  if $profile_class != '' and $manage {
    contain $profile_class
  }

  if $hardware_class != '' and $manage {
    contain $hardware_class
  }

  if $multipath_class != '' and $manage {
    contain $multipath_class
  }
}
