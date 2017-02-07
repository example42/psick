# This class manages the general hardening of a system. It just provides, as
# params, the names of the classes to include in order to manage specific
# hardening activities.
#
# @example Define all the available hardening classes. Set a class name to an
#          empty string to avoid to include it
#   profile::hardening::pam_class: '::profile::hardening::pam'
#   profile::hardening::packages_class: '::profile::hardening::packages'
#   profile::hardening::services_class: '::profile::hardening::services'
#   profile::hardening::tcpwrappers_class: '::profile::hardening::tcpwrappers'
#   profile::hardening::securetty_class: '::profile::hardening::securetty'
#   profile::hardening::network_class: '::profile::hardening::network'
#
# @param pam_class Name of the class to include to manage PAM
# @param packages_class Name of the class where are defined packages to remove
# @param services_class Name of the class to include re defined services to stop
# @param securetty_class Name of the class where /etc/securetty is managed
# @param tcpwrappers_class Name of the class to include to manage TCP wrappers
# @param network_class Name of the class where some network hardening is done
#
class profile::hardening (

  String $pam_class         = '',
  String $packages_class    = '',
  String $services_class    = '',
  String $tcpwrappers_class = '',
  String $securetty_class   = '',
  String $network_class     = '',

) {

  if $pam_class != '' {
    contain $pam_class
  }

  if $packages_class != '' {
    contain $packages_class
  }

  if $services_class != '' {
    contain $services_class
  }

  if $tcpwrappers_class != '' {
    contain $tcpwrappers_class
  }

  if $securetty_class != '' {
    contain $securetty_class
  }

  if $network_class != '' {
    contain $network_class
  }

}
