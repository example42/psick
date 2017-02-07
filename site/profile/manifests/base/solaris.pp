# Common solaris profile
# This profile is included in all the Solaris servers managed by Puppet.
# It exposes a list of parameters which define the name of the class to use for
# different common tasks. If the name is empty (as by default in most of the
# cases) no class is included.
# A special class name, customisable with the parameter pre_class defines the
# name of a class to include before all the others. This is the only case where
# a non empty class name must be defined.
# In the pre class you should define resources that are prerequisites for all
# the others, such as package repositories definition.
#
class profile::base::solaris (

  String $pre_class         = '::profile::pre',

  String $puppet_class      = '',
  String $mail_class        = '',
  String $network_class     = '',
  String $users_class       = '',
  String $monitor_class     = '',
  String $firewall_class    = '',
  String $logs_class        = '',
  String $backup_class      = '',

) {


  contain ::profile::settings
  contain $pre_class
  Class['::profile::settings'] -> Class[$pre_class]

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

}
