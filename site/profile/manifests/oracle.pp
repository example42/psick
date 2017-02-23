# Class profile::oracle
# Manages Oracle prerequisites and eventually installation (via oradb module)
# By default profile::oracle does nothing, besides includig a common settings
# class and exposing params to include the classes that manage oracle prerequisites,
# installation and generation of databases and other resources.
#
# @param prerequisites_class Name of the class that installs Oracle
#                            prerequisites. Must be defined.
# @param install_class Name of the class that installs Oracle (via oradb module)
# @param resources_class Name of the class that installs extra Oracle resources
# @param instances An hash of oracle instances to create (uses
#                  tools::oracle::instance)
#
class profile::oracle (
  String $prerequisites_class = '::profile::oracle::prerequisites',
  String $install_class       = '',
  String $resources_class     = '',
  Hash $instances             = { }
) {

  contain ::profile::oracle::params

  if $prerequisites_class != '' {
    contain $prerequisites_class
  }
  if $install_class != '' {
    contain $install_class
    Class[$prerequisites_class] -> Class[$install_class]
  }
  if $resources_class != '' {
    contain $resources_class
    Class[$prerequisites_class] -> Class[$install_class] -> Class[$resources_class]
  }

  $instances.each |$k,$o| {
    tools::oracle::instance { $k:
      require => Class[$install_class],
      *       => $o,
    }
  }
}
