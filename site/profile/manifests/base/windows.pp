# Common windows profile
# This profile is included in all the Windows servers managed by Puppet.
# It exposes a list of parameters which define the name of the class to use for
# different common tasks. If the name is empty (as by default in most of the
# cases) no class is included.
# A special class name, customisable with the parameter pre_class defines the
# name of a class to include before all the others. This is the only case where
# a non empty class name must be defined.
# In the pre class you should define resources that are prerequisites for all
# the others, such as package repositories definition.
#
class profile::base::windows (

  Boolean $enable,

  String $puppet_class,
  String $features_class,
  String $registry_class,
  String $network_class,
  String $users_class,
  String $hosts_class,
  String $monitor_class,
  String $firewall_class,
  String $antivirus_class,
  String $backup_class,
  String $time_class,

) {

  if $network_class != '' and $enable {
    contain $network_class
  }

  if $features_class != '' and $enable {
    contain $features_class
  }

  if $registry_class != '' and $enable {
    contain $registry_class
  }

  if $puppet_class != '' and $enable {
    contain $puppet_class
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

  if $hosts_class != '' and $enable {
    contain $hosts_class
  }

  if $firewall_class != '' and $enable {
    contain $firewall_class
  }

  if $antivirus_class != '' and $enable {
    contain $antivirus_class
  }

  if $time_class != '' and $enable {
    contain $time_class
  }
}
