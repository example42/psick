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
#   profile::hardening::suid_class: '::profile::hardening::suid_sgid'
#   profile::hardening::users_class: '::profile::hardening::users_sgid'
#   profile::hardening::securetty_class: '::profile::hardening::securetty'
#   profile::hardening::network_class: '::profile::hardening::network'
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the hardening profile.
# @param pam_class Name of the class to include to manage PAM
# @param packages_class Name of the class where are defined packages to remove
# @param services_class Name of the class to include re defined services to stop
# @param securetty_class Name of the class where /etc/securetty is managed
# @param tcpwrappers_class Name of the class to include to manage TCP wrappers
# @param suid_class Name of the class to include to remove SUID but from execs
# @param users_class Name of the class to manage users
# @param network_class Name of the class where some network hardening is done
#
class profile::hardening (

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
