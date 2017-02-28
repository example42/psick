# This class configures prerequisites resources for Oracle installation
# 
# To cope with existing alternative approaches, it's possible to define the name of
# the classes to use to manage each kind of resource.
# By default no class name is specified and nothing is done.
# To enable the profile classes use (you can specify alternstive classes):
# @example
# ---
#   profile::oracle::prerequisites::limits_class: 'profile::oracle::prerequisites::limits'
#   profile::oracle::prerequisites::sysctl_class: 'profile::oracle::prerequisites::sysctl'
#   profile::oracle::prerequisites::swap_class: 'profile::oracle::prerequisites::swap'
#   profile::oracle::prerequisites::packages_class: 'profile::oracle::prerequisites::packages'
#   profile::oracle::prerequisites::users_class: 'profile::oracle::prerequisites::users' 
#   profile::oracle::prerequisites::dirs_class: 'profile::oracle::prerequisites::dirs' 
#
class profile::oracle::prerequisites (
  Optional[String] $limits_class = undef,
  Optional[String] $sysctl_class = undef,
  Optional[String] $swap_class = undef,
  Optional[String] $packages_class = undef,
  Optional[String] $users_class = undef,
  Optional[String] $dirs_class = undef,
) {

  if $limits_class and $limits_class != '' { contain $limits_class }
  if $sysctl_class and $sysctl_class != '' { contain $sysctl_class }
  if $swap_class and $swap_class != '' { contain $swap_class }
  if $packages_class and $packages_class != '' { contain $packages_class }
  if $users_class and $users_class != '' { contain $users_class }
  if $dirs_class and $dirs_class != '' { contain $dirs_class }

}
