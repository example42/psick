# This class manages the general hardening of a system. It just provides, as
# params, the names of the classes to include in order to manage specific
# hardening activities.
#
# @example Define all the available hardening classes. Set a class name to an
#          empty string to avoid to include it
#   psick::hardening::pam_class: '::psick::hardening::pam'
#   psick::hardening::packages_class: '::psick::hardening::packages'
#   psick::hardening::services_class: '::psick::hardening::services'
#   psick::hardening::tcpwrappers_class: '::psick::hardening::tcpwrappers'
#   psick::hardening::suid_class: '::psick::hardening::suid_sgid'
#   psick::hardening::users_class: '::psick::hardening::users_sgid'
#   psick::hardening::securetty_class: '::psick::hardening::securetty'
#   psick::hardening::network_class: '::psick::hardening::network'
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the hardening psick.
# @param pam_class Name of the class to include to manage PAM
# @param packages_class Name of the class where are defined packages to remove
# @param services_class Name of the class to include re defined services to stop
# @param securetty_class Name of the class where /etc/securetty is managed
# @param tcpwrappers_class Name of the class to include to manage TCP wrappers
# @param suid_class Name of the class to include to remove SUID but from execs
# @param users_class Name of the class to manage users
# @param network_class Name of the class where some network hardening is done
#
class psick::hardening (

  Boolean $manage         = true,

  String $pam_class         = '',
  String $packages_class    = '',
  String $services_class    = '',
  String $tcpwrappers_class = '',
  String $suid_class        = '',
  String $users_class       = '',
  String $securetty_class   = '',
  String $network_class     = '',

) {

  if $pam_class != '' and $manage {
    contain $pam_class
  }

  if $packages_class != '' and $manage {
    contain $packages_class
  }

  if $services_class != '' and $manage {
    contain $services_class
  }

  if $tcpwrappers_class != '' and $manage {
    contain $tcpwrappers_class
  }

  if $suid_class != '' and $manage {
    contain $suid_class
  }

  if $users_class != '' and $manage {
    contain $users_class
  }

  if $securetty_class != '' and $manage {
    contain $securetty_class
  }

  if $network_class != '' and $manage {
    contain $network_class
  }

}
