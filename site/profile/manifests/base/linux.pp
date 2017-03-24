# The is the base profile included on all linux systems.
#
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
  Boolean $enable,

  String $network_class,
  String $mail_class,
  String $puppet_class,
  String $ssh_class,
  String $users_class,
  String $sudo_class,
  String $monitor_class,
  String $firewall_class,
  String $logs_class,
  String $backup_class,
  String $time_class,
  String $timezone_class,
  String $sysctl_class,
  String $dns_class,
  String $hardening_class,
  String $limits_class,
  String $hostname_class,
  String $hosts_class,
  String $update_class,
  String $motd_class,
  String $profile_class,

) {

  if $network_class != '' and $enable {
    contain $network_class
  }

  if $mail_class != '' and $enable {
    contain $mail_class
  }

  if $puppet_class != '' and $enable {
    contain $puppet_class
  }

  if $ssh_class != '' and $enable {
    contain $ssh_class
  }

  if $monitor_class != '' and $enable {
    contain $monitor_class
  }

  if $backup_class != '' and $enable {
    contain $backup_class
  }

  if $users_class != '' and $enable {
    contain $users_class
  }

  if $sudo_class != '' and $enable {
    contain $sudo_class
  }

  if $firewall_class != '' and $enable {
    contain $firewall_class
  }

  if $logs_class != '' and $enable {
    contain $logs_class
  }

  if $time_class != '' and $enable {
    contain $time_class
  }

  if $timezone_class != '' and $enable {
    contain $timezone_class
  }

  if $sysctl_class != '' and $enable {
    contain $sysctl_class
  }

  if $dns_class != '' and $enable {
    contain $dns_class
  }

  if $hardening_class != '' and $enable {
    contain $hardening_class
  }

  if $limits_class != '' and $enable {
    contain $limits_class
  }

  if $hostname_class != '' and $enable {
    contain $hostname_class
  }

  if $hosts_class != '' and $enable {
    contain $hosts_class
  }

  if $update_class != '' and $enable {
    contain $update_class
  }

  if $motd_class != '' and $enable {
    contain $motd_class
  }

  if $profile_class != '' and $enable {
    contain $profile_class
  }
}
