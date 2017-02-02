# This class manages backup.
#
# @example Include the legato class for backup:
#   profile::backup::legato_class: '::profile::backup::legato'
#
# @params legato_class Name of the class that manages Legato Installation
#
class profile::backup (
  String $legato_class   = '',
) {

  if $legato_class != '' {
    include $legato_class
  }

}
