# @summary Manages prerequisite classes o Darwin. They are applied before the others
#
# This class manages prerequisites resources for all the other classes.
# Basically package repositories, subscriptions and eventually proxy server to
# use.
# This profile class is the only one included by default on the base profiles.
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the pre profile.
# @param proxy_class Name of the class to include to the system's proxy server
# @param repo_class Name of the class to include to manage repos
#
# @example Including prerequisite proxy class
#    profile::pre::darwin::proxy_class: '::profile::darwin::proxy'
#
class profile::pre::darwin (
  # General switch. If false nothing is done.
  Boolean $manage         = true,
  
  String $proxy_class = '',
  String $repo_class  = '',
) {

  if $proxy_class != '' and $manage {
    contain $proxy_class
  }

  if $repo_class != '' and $manage {
    contain $repo_class
  }

}
