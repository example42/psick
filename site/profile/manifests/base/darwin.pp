# Common darwin profile
#
# Use _class params for exceptions and alternatives.
#
class profile::base::darwin (

  Boolean $enable,

  String $puppet_class,
  String $mail_class,
  String $network_class,
  String $users_class,
  String $monitor_class,
  String $firewall_class,
  String $logs_class,
  String $backup_class,

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

  if $monitor_class != '' and $enable {
    contain $monitor_class
  }

  if $backup_class != '' and $enable {
    contain $backup_class
  }

  if $users_class != '' and $enable {
    contain $users_class
  }

  if $firewall_class != '' and $enable {
    contain $firewall_class
  }

  if $logs_class != '' and $enable {
    contain $logs_class
  }

}
