# Common site class
#
# Use _class params for exceptions and alternatives.
#
class site (

  $pre_class         = '::profile::pre',

  $mail_class        = '::profile::mail::postfix',

  $puppet_class      = '',

  $network_class     = '::profile::network',
  $users_class       = '::profile::users',

  $monitor_class     = '::profile::monitor',
  $firewall_class    = '::profile::firewall::iptables',
  $logs_class        = '::profile::logs::rsyslog',

  $backup_class      = '',

) {

  if $pre_class and $pre_class != '' {
    contain $pre_class
  }

  if $network_class and $network_class != '' {
    contain $network_class
    Class[$pre_class] -> Class[$network_class]
  }

  if $mail_class and $mail_class != '' {
    contain $mail_class
    Class[$pre_class] -> Class[$mail_class]
  }

  if $puppet_class and $puppet_class != '' {
    contain $puppet_class
    Class[$pre_class] -> Class[$puppet_class]
  }

  if $monitor_class and $monitor_class != '' {
    contain $monitor_class
    Class[$pre_class] -> Class[$monitor_class]
  }

  if $backup_class and $backup_class != '' {
    contain $backup_class
    Class[$pre_class] -> Class[$backup_class]
  }

  if $users_class and $users_class != '' {
    contain $users_class
    Class[$pre_class] -> Class[$users_class]
  }

  if $firewall_class and $firewall_class != '' {
    contain $firewall_class
    Class[$pre_class] -> Class[$firewall_class]
  }

  if $logs_class and $logs_class != '' {
    contain $logs_class
    Class[$pre_class] -> Class[$logs_class]
  }


  # Role specific class is loaded, if $role is set
  if $::role and $::role != '' {
    include "::role::${::role}"
    contain "::role::${::role}"
    Class[$pre_class] -> Class["::role::${::role}"]
  }
}
