# Generic class to manage tcpwrappers
#
# @param hosts_allow_template The erb template (as used in template()) to use
#                             to manage the content of /etc/hosts.allow
#                             Set it to an empty string to avoid to manage it.
# @param hosts_deny_template The erb template (as used in template()) to use
#                            to manage the content of /etc/hosts.deny
#                            Set it to an empty string to avoid to manage it.
#
class psick::hardening::tcpwrappers (
  String $hosts_allow_template = 'psick/hardening/tcpwrappers/hosts.allow.erb',
  String $hosts_deny_template  = 'psick/hardening/tcpwrappers/hosts.deny.erb',
) {

  if $hosts_allow_template != '' {
    file { '/etc/hosts.allow':
      ensure  => file,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template($hosts_allow_template),
    }
  }

  if $hosts_deny_template != '' {
    file { '/etc/hosts.deny':
      ensure  => file,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template($hosts_deny_template),
    }
  }
}
