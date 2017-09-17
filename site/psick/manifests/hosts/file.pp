# This class manages the content of the /etc/hosts file
#
# @param template The erb template to use to manage the content of /etc/hosts
# @param ipaddress The IP address to use for the node hostname
# @param domain the domain to use for the node domain name
# @param hostname The hostname to use for the node hostname
# @param extra_hosts An array of extra lines to add (one line for array element)
#                    to /etc/hosts. Note: this is not a real class parameter but
#                    a variable looked up via
#                    hiera_array('psick::hosts::file::extra_hosts', [] )
#
class psick::hosts::file (
  String $template  = 'psick/hosts/file/hosts.erb',

  String $ipaddress             = $::psick::settings::primary_ip,
  Variant[Undef,String] $domain = $::domain,
  String $hostname              = $::hostname,
) {

  $extra_hosts=hiera_array('psick::hosts::file::extra_hosts', [] )

  file { '/etc/hosts':
    ensure  => file,
    content => template($template),
  }

}
