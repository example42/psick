# The base profile included on all Windows systems.
#
# By default it does not manage any resource.
# It exposes a list of parameters which define the name of the class to use for
# different common tasks. If the name is empty (as always by default)
# no class is included.
#
# @example Manage some resources with relevant modules or profiles
#   profile::base::windows::puppet_class: '::puppet'
#   profile::base::windows::users_class: '::profile::users::static'
#
# @example Completely disable management of any resource from this class
#   profile::base::windows::manage: false
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the base profile.
#
# @param_$class All the other parameters are used to define the name of the
#   class for include in order to manage a specific system configuration.
#
class profile::base::windows (

  Boolean $manage         = true,

  String $puppet_class    = '',
  String $features_class  = '',
  String $registry_class  = '',
  String $network_class   = '',
  String $users_class     = '',
  String $hosts_class     = '',
  String $monitor_class   = '',
  String $firewall_class  = '',
  String $antivirus_class = '',
  String $backup_class    = '',
  String $time_class      = '',
  String $services_class  = '',

) {

  if $network_class != '' and $manage {
    contain $network_class
  }

  if $features_class != '' and $manage {
    contain $features_class
  }

  if $registry_class != '' and $manage {
    contain $registry_class
  }

  if $puppet_class != '' and $manage {
    contain $puppet_class
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

  if $hosts_class != '' and $manage {
    contain $hosts_class
  }

  if $firewall_class != '' and $manage {
    contain $firewall_class
  }

  if $antivirus_class != '' and $manage {
    contain $antivirus_class
  }

  if $time_class != '' and $manage {
    contain $time_class
  }

  if $services_class != '' and $manage {
    contain $services_class
  }

}
