# This class manages prerequisites resources for all the other classes.
# Basically package repositories and subscriptions.
# This profile class is the only one included by default on the base profiles.
#
# @param include_defaults Define if to include the default prerequisites class
#                         which manages subscriptions to Satellite or similar
#                         central repository management systems
# @param rpmgpg_class Name of the class to include to manage gpgkeys on rpm
#                     based systems
# @param repo_class Name of the class to include to manage additional repos.
#
# @example Including additional classes for rpmgpg and repo
#    profile::pre::rpmgpg_class: '::profile::pre::gpgkeys'
#    profile::pre::repo_class: '::profile::repo'
#
class profile::pre (
  Boolean $include_defaults = true,
  String $rpmgpg_class      = '',
  String $repo_class        = '',
) {

  if $include_defaults {
    case $::operatingsystem {
      'RedHat': { contain ::profile::pre::rhn }
      'OracleLinux': { contain ::profile::pre::rhn }
      'CentOS': { contain ::profile::pre::rhn }
      'SLES': { contain ::profile::pre::rhn }
      'Ubuntu': { contain ::profile::pre::ubuntu }
      default: { notice("No pre class for ${::operatingsystem}") }
    }
  }

  if $rpmgpg_class != '' and $::osfamily =~ /RedHat|Suse/ {
    contain $rpmgpg_class
  }

  if $repo_class != '' {
    contain $repo_class
  }
}
