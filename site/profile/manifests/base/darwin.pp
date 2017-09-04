# The base profile included on all darwin systems.
#
# By default it does not manage any resource.
# It exposes a list of parameters which define the name of the class to use for
# different common tasks. If the name is empty (as always by default)
# no class is included.
#
# @example Manage some resources with relevant modules or profiles
#   profile::base::darwin::puppet_class: '::puppet'
#   profile::base::darwin::users_class: '::profile::users::static'
#
# @example Completely disable management of any resource from this class
#   profile::base::darwin::manage: false
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the base profile.
#
# @param_$class All the other parameters are used to define the name of the
#   class for include in order to manage a specific system configuration.
class profile::base::darwin (

  Boolean $manage        = true,

  String $puppet_class   = '',
  String $mail_class     = '',
  String $network_class  = '',
  String $users_class    = '',
  String $monitor_class  = '',
  String $firewall_class = '',
  String $logs_class     = '',
  String $backup_class   = '',

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

  if $monitor_class != '' and $manage {
    contain $monitor_class
  }

  if $backup_class != '' and $manage {
    contain $backup_class
  }

  if $users_class != '' and $manage {
    contain $users_class
  }

  if $firewall_class != '' and $manage {
    contain $firewall_class
  }

  if $logs_class != '' and $manage {
    contain $logs_class
  }

}
