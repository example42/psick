# Manage /etc/hosts using a template file
#
class profile::hosts::file (
  String $template  = 'profile/hosts/file/hosts.erb',

  String $ipaddress = $::ipaddress,
  String $domain    = $::domain,
  String $hostname  = $::hostname,
) {

  file { '/etc/hosts':
    ensure  => present,
    content => template($template),
  }

}
